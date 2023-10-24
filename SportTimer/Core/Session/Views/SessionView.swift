//
//  SessionView.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import SwiftUI

struct SessionView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var vm: SessionViewModel
    
    var body: some View {
        VStack {
            Text(String(format: "%d", vm.counter))
                .font(.system(size: 120))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            
            Text("\(vm.step!.getName())")
                .bold()
                .foregroundStyle(.white)

            List {
                ForEach(Array(vm.session!.enumerated()), id: \.offset) {(index, acti) in
                    Button(action: {
                        vm.changeStep(step: index)
                    }, label: {
                        HStack {
                            Text("\(acti.getName())")
                            Spacer()
                            Text("\(acti.time)")
                        }
                    })
                    .tint(.primary)
                    .listRowBackground(vm.stepId == index ? Color.primary.opacity(0.2) : nil)
                }
            }
        }
        .background(vm.step!.getColor())
        .toolbar {
            ToolbarItem {
                Button(action: {
                    vm.mode == .paused || vm.mode == .stopped ?
                    vm.start() : vm.pause()
                }, label: {
                    Image(systemName:
                            vm.mode == .paused || vm.mode == .stopped ?
                          "play.fill" : "pause.fill")
                    .foregroundStyle(Color.white)
                })
            }
        }
        .onDisappear {
            vm.stop()
        }
    }
}

//
//#Preview {
//    SessionView(vm: Workout)
//}
