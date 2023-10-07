//
//  SessionViewV2.swift
//  SportTimer
//
//  Created by dleegan on 01/10/2023.
//

import SwiftUI

struct SessionViewV2: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var finalTimer: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .second, value: 30, to: Date()) ?? Date()
    
    func updateTimer() {
        let remaining = Calendar.current.dateComponents([.second], from: Date(), to: futureDate)
        let minute = remaining.second ?? 0
        finalTimer = "\(minute)"
    }

    var body: some View {
        ZStack {
            Text(finalTimer)
        }
        .onReceive(timer, perform: { _ in
            updateTimer()
        })
        
    }
}

#Preview {
    SessionViewV2()
}
