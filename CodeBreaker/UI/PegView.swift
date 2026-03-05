//
//  PegView.swift
//  CodeBreaker
//
//  Created by Marin Denić on 26.02.2026..
//

import SwiftUI

struct PegView: View {
    
    // MARK: Data In
    let peg: Peg
    
    // MARK: Data Owned by Me
    let pegShape = Circle()
    
    // MARK: - Body
    var body: some View {
        pegShape
            .contentShape(Rectangle())
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(peg)
    }
}

#Preview {
    PegView(peg: .blue)
        .padding()
}
