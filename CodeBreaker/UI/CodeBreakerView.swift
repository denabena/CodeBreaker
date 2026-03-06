//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Marin Denić on 23.02.2026..
//

import SwiftUI

struct CodeBreakerView: View {
    
    //MARK: Data Shared With Me
    let game: CodeBreaker
    
    // MARK: Data Owned by Me
    @State private var selection: Int = 0
    @State private var restarting: Bool = false
    @State private var hideMostRecentMarkers: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver || restarting {
                    CodeView(code: game.guessCode, selection: $selection){
                        Button("Guess", action: guess).flexibleSystemFont()
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting && game.isOver ? 0 : 1)
                }

                
                ForEach(game.attempts, id: \.pegs) { attempt in
                    CodeView(code: attempt) {
                        let showMarkers = !hideMostRecentMarkers || attempt.pegs != game.attempts.first?.pegs
                        if showMarkers, let matches = attempt.matches {
                            MatchMarkers(matches: matches)
                        }
                    }
                    .transition(
                        .attempt(game.isOver)
                    )
                }
            }
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button("Restart", systemImage: "arrow.circlepath", action: restart)
                }
                ToolbarItem {
                    ElapsedTime(startTime: game.startTime, endTime: game.endTime)
                        .flexibleSystemFont()
                        .monospaced(true)
                        .lineLimit(1)
                }
            }
            if !game.isOver {
                PegChooser(pegChoices: game.possibleOptions, onChange: changePegAtSelection)
                    .transition(.pegChooser)
            }
        }
        .padding()
        
        
    }

    func changePegAtSelection(to peg: Peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
    }
    
    func guess() {
        withAnimation(.guess) {
            game.attemptGuess()
            game.guessCode.reset()
            selection = 0
            hideMostRecentMarkers = true
        } completion: {
            hideMostRecentMarkers = false
        }
    }
    
    func restart() {
        withAnimation(.restart) {
            restarting = true
        } completion: {
            withAnimation(.restart) {
                game.restartGame()
                selection = 0
                restarting = false
            }
        }
    }
}

#Preview {
    @Previewable @State var game = CodeBreaker(name: "Preview", possibleOptions: [.red, .blue, .yellow, .green])
    NavigationStack {
        CodeBreakerView(game: game)
    }
}
