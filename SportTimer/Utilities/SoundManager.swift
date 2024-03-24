//
//  SoundManager.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import Foundation
import AudioToolbox
import SwiftUI

enum SoundOption: String {
    case whistle
    case ending
}

class SoundManager {
    static let instance = SoundManager()

    func playSound(stepSound: SoundOption) {
        guard let soundURL = Bundle.main.url(forResource: stepSound.rawValue, withExtension: ".wav") else {
            return
        }
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
        
        feetbackWithSound(stepSound: stepSound)
    }

    func feetbackWithSound(stepSound: SoundOption) {
        switch stepSound {
            case .whistle:
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            case .ending:
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
}
