//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Marin Denić on 23.02.2026..
//

import SwiftUI

struct CodeBreakerViewA2: View {
    @State var game = CodeBreaker(possibleOptions: [.brown, .yellow, .black, .green, .blue])
    
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
            restartButton
            
            
            
        }
        .padding()
        
        
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                if !game.guessCode.pegs.allSatisfy( { $0 == Code.missingPeg }) && !game.attempts.contains(where: { $0.pegs == game.guessCode.pegs }) {
                    game.attemptGuess()
                }
                
            }
        }
        .font(.system(size: 15))
        .minimumScaleFactor(0.1)
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation {
                game.restartGame()
            }
            
        }
        .font(.system(size: 20))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missingPeg {
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
            //MatchMarkersA2(matches: code.matches, circleCount: game.count)
                .overlay {
                    if code.kind == .guesscode {
                        guessButton
                    }
                }
                .frame(minWidth: 50, minHeight: 50)
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
    CodeBreakerViewA2()
}
