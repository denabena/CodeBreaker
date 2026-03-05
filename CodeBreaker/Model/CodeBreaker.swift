//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Marin Denić on 24.02.2026..
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code
    var guessCode: Code
    var attempts: [Code] = []
    var possibleOptions: [Peg]
    var count: Int
    var startTime: Date = Date.now
    var endTime: Date?
    
    init(possibleOptions: [Peg] = [.green, .red, .yellow, .blue], count: Int = 4) {
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
    
    mutating func attemptGuess() {
        guard !attempts.contains(where: { $0.pegs == guessCode.pegs }) else { return }
        var attempt = guessCode
        attempt.kind = .attempt(guessCode.match(against: masterCode))
        attempts.insert(attempt, at: 0)
        
        if isOver {
            masterCode.kind = .mastercode(isHidden: false)
            endTime = .now
        }
    }
    
    mutating func changePeg(at index: Int) {
        let existingPeg = guessCode.pegs[index]
        if let indexOfExistingPegInPegChoices = possibleOptions.firstIndex(of: existingPeg) {
            guessCode.pegs[index] = possibleOptions[(indexOfExistingPegInPegChoices + 1) % possibleOptions.count]
        }
        else {
            guessCode.pegs[index] = possibleOptions.first ?? Code.missingPeg
        }
        
    }
    
    mutating func restartGame() {
        self = CodeBreaker(possibleOptions: possibleOptions, count: 4)
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guessCode.pegs.indices.contains(index) else { return }
        guessCode.pegs[index] = peg
    }
}

extension Peg {
    static let missing = Color.clear
}
