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
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink(value: game) {
                        GameSummary(game: game)
                    }
                    NavigationLink(value: game.masterCode.pegs) {
                        Text("Cheat")
                    }
                }
                .onDelete { offsets in
                    games.remove(atOffsets: offsets)
                }
                .onMove { offsets, destination in
                    games.move(fromOffsets: offsets, toOffset: destination)
                }
            }
            .navigationDestination(for: CodeBreaker.self) { game in
                CodeBreakerView(game: game)
            }
            .navigationDestination(for: [Peg].self) { peg in
                PegChooser(pegChoices: peg)
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
            }

        }
        .onAppear {
            if games.isEmpty {
                games.append(CodeBreaker(name: "Mastermind", possibleOptions: [.red, .blue, .green, .yellow]))
                games.append(CodeBreaker(name: "Earth Tones", possibleOptions: [.orange, .brown, .black, .yellow, .green]))
                games.append(CodeBreaker(name : "Undersea", possibleOptions: [.blue, .indigo, .cyan]))
            }
        }
    }
}

#Preview {
    GameChooser()
}
