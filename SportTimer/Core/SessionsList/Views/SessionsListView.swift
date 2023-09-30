//
//  SessionsListView.swift
//  SportTimer
//
//  Created by dleegan on 30/09/2023.
//

import SwiftUI

struct SessionsListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach (1...10, id: \.self) {_ in 
                    VStack {
                        Text("Hello, World!")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("Sessions")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        //                    print(')
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }

    }
}

#Preview {
    SessionsListView()
}
