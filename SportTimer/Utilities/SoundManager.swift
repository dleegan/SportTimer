//
//  SoundManager.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import Foundation
import AVKit

enum SoundOption: String {
    case whistle
    case ending
}

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(stepSound: SoundOption) {
        guard let url = Bundle.main.url(forResource: stepSound.rawValue, withExtension: ".wav") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
