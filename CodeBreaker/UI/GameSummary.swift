//
//  GameSummary.swift
//  CodeBreaker
//
//  Created by Marin Denić on 05.03.2026..
//

import SwiftUI

struct GameSummary: View {
    let game: CodeBreaker
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(game.name).font(.title)
            PegChooser(pegChoices: game.possibleOptions)
                .frame(maxHeight: 50)
            Text("^[\(game.attempts.count) attempt](inflect: true)")
        }    }
}

#Preview {
    List {
        GameSummary(game: CodeBreaker(name: "Preview", possibleOptions: [.red, .cyan, .yellow]))
    }
    List {
        GameSummary(game: CodeBreaker(name: "Preview", possibleOptions: [.red, .cyan, .yellow]))
    }
    .listStyle(.plain)
}
