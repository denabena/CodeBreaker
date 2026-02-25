//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Marin Denić on 23.02.2026..
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker(possibleOptions: [.brown, .yellow, .black, .green], count: 4)
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                HStack {
                    view(for: game.guessCode)
                }
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            
            
            
        }
        .padding()
        
        
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guesscode {
                            game.changePeg(at: index)
                        }
                    }
                
            }
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guesscode {
                        guessButton
                    }
                }
        }
    }
}

/*
func Balls(colors: Array<Color>) -> some View {
    HStack{
        ForEach(colors.indices, id: \.self) { index in
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(colors[index])
                
        }
        
    }
}
 */





#Preview {
    CodeBreakerView()
}
