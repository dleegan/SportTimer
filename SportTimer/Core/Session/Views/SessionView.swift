//
//  SessionView.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var vm = SessionViewModel()
    
    var body: some View {
        VStack {
            HStack {
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
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Text(String(format: "%d", vm.counter))
                .font(.system(size: 120))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            
            Text("\(vm.step.getName())")
                .bold()
                .foregroundStyle(.white)

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
