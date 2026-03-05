//
//  ElapsedTime.swift
//  CodeBreaker
//
//  Created by Marin Denić on 04.03.2026..
//

import SwiftUI

struct ElapsedTime: View {
    
    let startTime: Date
    let endTime: Date?
    
    init(startTime: Date, endTime: Date?) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var body: some View {
        if let endTime {
            Text(endTime, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        }
        else {
            Text(TimeDataSource<Data>.currentDate, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        }
    }
}
