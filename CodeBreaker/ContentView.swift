//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Marin Denić on 23.02.2026..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16, content: greeting)
        .padding()
    }
}

@ViewBuilder
func greeting() -> some View {
    Image(systemName: " ")
        .imageScale(Image.Scale.large)
        .foregroundStyle(Color.secondary)

    Text("Hello, World!")
}

struct TestingView: View {
    var body: some View {
        VStack {
            Balls(colors: [.red, .green, .green, .green])
            Balls(colors: [.blue, .red, .green, .yellow])
            Balls(colors: [.yellow, .green, .blue, .green])
            
            
        }
        
    }
}

func Balls(colors: Array<Color>) -> some View {
    HStack{
        ForEach(colors.indices, id: \.self) { index in
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(colors[index])
                
        }
        
    }
}





#Preview {
    TestingView()
}
