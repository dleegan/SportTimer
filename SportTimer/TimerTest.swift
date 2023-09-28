//
//  TimerTest.swift
//  SportTimer
//
//  Created by dleegan on 28/09/2023.
//

import SwiftUI


struct TimerTest: View {
    @ObservedObject var timer_vm = TimerManager()
   
    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button(action: {
                    timer_vm.mode == .paused || timer_vm.mode == .stopped ? 
                    timer_vm.start() : timer_vm.pause()
                }, label: {
                    Image(systemName: 
                            timer_vm.mode == .paused || timer_vm.mode == .stopped ?
                          "play.fill" : "pause.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                })
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            Text(String(format: "%d", timer_vm.secondsElapsed))
                .font(.system(size: 120))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            
            //Spacer()
            
            List {
                ForEach(timer_vm.session) { acti in
                    Text("\(acti.getName()) " + "\(acti.time)")
                }
            }
        }
        .background(timer_vm.step.getColor())
    }
}

#Preview {
    TimerTest()
}
