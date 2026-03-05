//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by Marin Denić on 27.02.2026..
//

import SwiftUI

struct PegChooser: View {
    
    var pegChoices: [Peg]
    var onChange: ((Peg) -> Void)?
    
    var body: some View {
            HStack {
                ForEach(pegChoices, id: \.self) { peg in
                    Button {
                        onChange?(peg)
                    } label: {
                        PegView(peg: peg)
                    }
                }
            }
        }
    }

//#Preview {
//    PegChooser()
//}
