//
//  MessagesView.swift
//  SportTimer
//
//  Created by dleegan on 05/04/2024.
//

import SwiftUI

struct MessagesView: View {
    @StateObject var model = DeviceFinderViewModel()
    
    var body: some View {
        NavigationStack(path: $model.joinedPeer) {
            List(model.peers) { peer in
                HStack {
                    Image(systemName: "iphone.gen1")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    
                    Text(peer.peerId.displayName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 5)
                .onTapGesture {
                    model.selectedPeer = peer
                }
            }
            .alert(item: $model.permissionRequest, content: { request in
                Alert(
                    title: Text("Do you want to join \(request.peerId.displayName)"),
                    primaryButton: .default(Text("Yes"), action: {
                        request.onRequest(true)
                        model.show(peerId: request.peerId)
                    }),
                    secondaryButton: .cancel(Text("No"), action: {
                        request.onRequest(false)
                    })
                )
            })
            .navigationDestination(for: PeerDevice.self, destination: { peer in
                MessengerView()
                    .environmentObject(model)
                    .toolbar(.hidden, for: .tabBar)
            })
            .onAppear {
                model.startBrowsing()
            }
            .onDisappear {
                model.finishBrowsing()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle("Press to be discoverable", isOn: $model.isAdvertised)
                        .toggleStyle(.switch)
                }
            }
        }
    }
}

#Preview {
    MessagesView()
}
