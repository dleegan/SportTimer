//
//  PeerDevice.swift
//  SportTimer
//
//  Created by dleegan on 05/04/2024.
//

import Foundation
import MultipeerConnectivity

struct PeerDevice: Identifiable, Hashable {
    let id = UUID()
    let peerId: MCPeerID
}
