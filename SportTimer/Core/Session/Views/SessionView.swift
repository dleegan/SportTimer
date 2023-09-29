//
//  SessionView.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var vm = TimerManager()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    vm.mode == .paused || vm.mode == .stopped ?
                    vm.start() : vm.pause()
                }, label: {
                    Image(systemName:
                            vm.mode == .paused || vm.mode == .stopped ?
                          "play.fill" : "pause.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                })
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            Text(String(format: "%d", vm.secondsElapsed))
                .font(.system(size: 120))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            
            //Spacer()
            
            List {
                ForEach(vm.session) { acti in
                    Text("\(acti.getName()) " + "\(acti.time)")
                }
            }
        }
        .background(vm.step.getColor())
    }
}

#Preview {
    SessionView()
}
