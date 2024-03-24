//
//  SessionView.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import SwiftUI
import BackgroundTasks

struct SessionView: View {
    @Environment(\.scenePhase) private var phase
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

            ExtractedView(vm: vm)
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
//        .onChange(of: phase, { oldValue, newValue in
//            switch newValue {
//                case .background:
//                    vm.timer.invalidate()
//                    vm.bgTimer()
//                case .active:
//                    if (vm.isOnBg) {
//                        vm.timerBG.invalidate()
//                        vm.isOnBg = false
//                        vm.start()
//                    }
//                default: break
//            }
//        })
        
    }
}


struct ExtractedView: View {
    var vm: SessionViewModel

    var body: some View {
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
}


//#Preview {
//    SessionView(vm: Workout)
//}
