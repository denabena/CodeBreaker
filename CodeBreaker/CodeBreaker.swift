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
    
    init(possibleOptions: [Peg] = [.green, .red, .yellow, .blue], count: Int = 4) {
        masterCode = Code (kind: .mastercode, count: count)
        guessCode = Code (kind: .guesscode, count: count)
        self.possibleOptions = possibleOptions
        self.count = count
        masterCode.randomize(from: possibleOptions)
        print(masterCode)
    }
    
    mutating func attemptGuess() {
        var attempt = guessCode
        attempt.kind = .attempt(guessCode.match(against: masterCode))
        attempts.append(attempt)
    }
    
    mutating func changePeg(at index: Int) {
        let existingPeg = guessCode.pegs[index]
        if let indexOfExistingPegInPegChoices = possibleOptions.firstIndex(of: existingPeg) {
            guessCode.pegs[index] = possibleOptions[(indexOfExistingPegInPegChoices + 1) % possibleOptions.count]
        }
        else {
            guessCode.pegs[index] = possibleOptions.first ?? Code.missing
        }
        
    }
    
    mutating func restartGame() {
        self = CodeBreaker(possibleOptions: possibleOptions, count: .random(in: 3...6))
    }
}

struct Code {
    var kind: Kind
    var pegs: [Peg]
    
    init(kind: Kind = Kind.undefined, count: Int) {
        self.kind = kind
        self.pegs = Array.init(repeating: Code.missing, count: count)
    }
    
    static let missing: Peg = .clear
    
    enum Kind: Equatable {
        case mastercode
        case guesscode
        case attempt ([Match])
        case undefined
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches): return matches
        default: return []
        }
    
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}
