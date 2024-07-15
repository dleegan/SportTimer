//
//  SessionView.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import SwiftUI
import BackgroundTasks
import UserNotifications

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
                .contentTransition(.numericText(value: Double(vm.counter)))
            
            Text("\(vm.step!.getName())")
                .bold()
                .foregroundStyle(.white)
            
            myListItems
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
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in
            }
        })
        //        .onDisappear {
        //            vm.stop()
        //        }
    }


    private var myListItems: some View {
        List {
            ForEach(Array(vm.session!.enumerated()), id: \.offset) {(index, acti) in
                Button(action: {
                    vm.changeStep(step: index)
                }, label: {
                    HStack {
                        Text("\(index). \(acti.getName())")
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
