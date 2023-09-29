//
//  StepModeModel.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import Foundation
import SwiftUI

struct StepModeModel: Identifiable {
    enum mode {
        case prepare
        case work
        case rest
    }
    
    let id: UUID = UUID()
    let name: mode
    let time: Int
    
    func getName() -> String {
        switch self.name {
            case .prepare:
                return "Prepare"
            case .work:
                return "Work"
            case .rest:
                return "Rest"
        }
    }
    
    func getColor() -> Color {
        switch self.name {
            case .prepare:
                return .green
            case .work:
                return .red
            case .rest:
                return .blue
        }
    }
}
