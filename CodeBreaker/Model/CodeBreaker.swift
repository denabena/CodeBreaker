//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Marin Denić on 24.02.2026..
//

import SwiftUI

typealias Peg = Color

@Observable class CodeBreaker {
    var name: String
    var masterCode: Code
    var guessCode: Code
    var attempts: [Code] = []
    var possibleOptions: [Peg]
    var count: Int
    var startTime: Date = Date.now
    var endTime: Date?
    
    init(name: String = "CodeBreaker", possibleOptions: [Peg] = [.green, .red, .yellow, .blue], count: Int = 4) {
        self.name = name
        masterCode = Code (kind: .mastercode(isHidden: true), count: count)
        guessCode = Code (kind: .guesscode, count: count)
        self.possibleOptions = possibleOptions
        self.count = count
        masterCode.randomize(from: possibleOptions)
        print(masterCode)
    }
    
    var isOver: Bool {
        attempts.first?.pegs == masterCode.pegs
    }
    
    func attemptGuess() {
        guard !attempts.contains(where: { $0.pegs == guessCode.pegs }) else { return }
        var attempt = guessCode
        attempt.kind = .attempt(guessCode.match(against: masterCode))
        attempts.insert(attempt, at: 0)
        
        if isOver {
            masterCode.kind = .mastercode(isHidden: false)
            endTime = .now
        }
    }
    
    func changePeg(at index: Int) {
        let existingPeg = guessCode.pegs[index]
        if let indexOfExistingPegInPegChoices = possibleOptions.firstIndex(of: existingPeg) {
            guessCode.pegs[index] = possibleOptions[(indexOfExistingPegInPegChoices + 1) % possibleOptions.count]
        }
        else {
            guessCode.pegs[index] = possibleOptions.first ?? Code.missingPeg
        }
        
    }
    
    func restartGame() {
        masterCode.kind = .mastercode(isHidden: true)
        masterCode.randomize(from: possibleOptions)
        guessCode.reset()
        attempts.removeAll()
        startTime = .now
        endTime = nil
    }
    
    func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guessCode.pegs.indices.contains(index) else { return }
        guessCode.pegs[index] = peg
    }
}

extension Peg {
    static let missing = Color.clear
}

extension CodeBreaker: Identifiable, Hashable {
    static func == (lhs: CodeBreaker, rhs: CodeBreaker) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
