//
//  GameChanger.swift
//  CodeBreaker
//
//  Created by Marin Denić on 05.03.2026..
//

import SwiftUI

struct GameChooser: View {
    @State private var games: [CodeBreaker] = []
    
    var body: some View {
        List (games, id: \.possibleOptions) { game in
            PegChooser(pegChoices: game.possibleOptions)
        }
        onAppear {
            if games.isEmpty {
                games.append(CodeBreaker(possibleOptions: [.red, .blue, .green, .yellow]))
                //games.append(CodeBreaker(possibleOptions: [.orange, .brown, .black, .yellow, .green]))
                //games.append(CodeBreaker(possibleOptions: [.blue, .indigo, .cyan]))
            }
        }
    }
}

#Preview {
    GameChooser()
}
