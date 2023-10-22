//
//  WorkoutBuilderView.swift
//  SportTimer
//
//  Created by dleegan on 11/10/2023.
//

import SwiftUI
import SwiftData

struct WorkoutBuilderView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var workout: Workout
    @StateObject private var vm: SessionViewModel = SessionViewModel()
    @State var show: Bool = false
    
    var body: some View {
        ZStack {
            Form(content: {
                Section("Titre") {
                    TextField("Nom", text: $workout.title)
                }
                Section("Workout") {
                    LabeledContent("Prepare", content: {
                        TextField("0", value: $workout.prepare, formatter: NumberFormatter())
                    })
                    LabeledContent("Work", content: {
                        TextField("0", value: $workout.work, formatter: NumberFormatter())
                    })
                    LabeledContent("Rest", content: {
                        TextField("0", value: $workout.rest, formatter: NumberFormatter())
                    })
                    LabeledContent("Cycles", content: {
                        TextField("0", value: $workout.cycles, formatter: NumberFormatter())
                    })
                    LabeledContent("Sets", content: {
                        TextField("0", value: $workout.sets, formatter: NumberFormatter())
                    })
                    LabeledContent("Rest between step", content: {
                        TextField("0", value: $workout.rest_between_step, formatter: NumberFormatter())
                    })
                    LabeledContent("Cool down", content: {
                        TextField("0", value: $workout.cool_down, formatter: NumberFormatter())
                    })
                }
                .keyboardType(.numberPad)
            })
            .formStyle(.automatic)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                workout.created_at = Date()
            }
            
            Button(action: {
                vm.generateData(workout: workout)
                show.toggle()
            }, label: {
                Text("Lancer")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25.0)
                    )
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
            .navigationDestination(isPresented: $show) {
                SessionView(vm: vm)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

//#Preview {
//    WorkoutBuilderView()
//        .modelContainer(for: Workout.self, inMemory: true)
//}
