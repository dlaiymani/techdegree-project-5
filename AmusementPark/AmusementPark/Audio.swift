//
//  Audio.swift
//  AmusementPark
//
//  Created by davidlaiymani on 14/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation
import AudioToolbox


enum Sounds: String {
    case accessGranted = "AccessGranted"
    case accessDenied = "AccessDenied"
}

class SoundEffectPlayer {
    var sound: SystemSoundID = 0
    
    func playSound(for accessSound: Sounds) {
        let path = Bundle.main.path(forResource: accessSound.rawValue, ofType: "wav")!
        let soundURL = URL(fileURLWithPath: path) as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
}
