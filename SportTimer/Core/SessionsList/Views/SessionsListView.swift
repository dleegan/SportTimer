//
//  SessionsListView.swift
//  SportTimer
//
//  Created by dleegan on 30/09/2023.
//

import SwiftUI
import SwiftData

struct SessionsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Workout.created_at, order: .reverse)], animation: .default) private var workouts: [Workout]
    
    @State var showEdit: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (workouts) {workout in
                    NavigationLink {
                        WorkoutBuilderView(workout: workout)
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(workout.title)
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Sessions")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showEdit.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .navigationDestination(isPresented: $showEdit) {
                        let newWorkout = Workout(title: "")
                        WorkoutBuilderView(workout: newWorkout)
                            .toolbar(.hidden, for: .tabBar)
                            .onDisappear {
                                modelContext.insert(newWorkout)
                            }
                    }
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(workouts[index])
            }
        }
    }
}

#Preview {
    SessionsListView()
        .modelContainer(for: Workout.self, inMemory: true)
}
