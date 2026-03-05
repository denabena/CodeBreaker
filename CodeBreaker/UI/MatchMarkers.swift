//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Marin Denić on 24.02.2026..
//

import SwiftUI

struct MatchMarkers: View {
    
    // MARK: Data In
    let matches: [Match]
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            HStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        let exactCount = matches.count { $0 == .exact }
        let foundCount = matches.count(where:  { $0 != .nomatch } )
        
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary: Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchMarkers(matches: [.exact, .exact, .exact, .exact])
}
