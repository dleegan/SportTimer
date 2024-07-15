//
//  PermitionResquest.swift
//  SportTimer
//
//  Created by dleegan on 05/04/2024.
//

import Foundation
import MultipeerConnectivity

struct PermitionRequest: Identifiable {
    let id = UUID()
    let peerId: MCPeerID
    let onRequest: (Bool) -> Void
}
