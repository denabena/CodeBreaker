//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Marin Denić on 24.02.2026..
//

import SwiftUI

struct MatchMarkers: View {
    
    var matches: [Match]
    var circleCount: Int
    var halfCount: Int { circleCount % 2 == 0 ? (circleCount / 2) : (circleCount / 2 + 1)}
    var body: some View{
        HStack {
            DummyPegs(circleCount: circleCount)
            VStack {
                HStack {
                    ForEach(0..<halfCount, id: \.self) { index in
                        matchMarker(peg: index)
                    }
                }
                HStack {
                    ForEach(halfCount..<halfCount * 2, id: \.self) { index in
                        matchMarker(peg: index)
                    }
                }
            }
        }
        .padding()
        
    }
    
    
    
    func matchMarker(peg: Int) -> some View {
        let exactCount = matches.count { $0 == .exact }
        let foundCount = matches.count(where:  { $0 != .nomatch } )
        
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary: Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
    
    func DummyPegs(circleCount: Int) -> some View {
        
        return ForEach(0..<circleCount, id: \.self) {index in
                Circle()

        }
            
    }
}

enum Match {
    case nomatch
    case exact
    case inexact
}

#Preview {
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 3)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 3)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 4)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 4)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 4)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 6)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 6)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 5)
    MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch], circleCount: 5)
}
