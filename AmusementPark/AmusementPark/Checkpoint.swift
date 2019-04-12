//
//  Checkpoint.swift
//  AmusementPark
//
//  Created by davidlaiymani on 12/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

enum CheckpointType {
    case restrictedArea
    case skipTheLines
    case register
}

//A checkpoint has a type and allows an Entrant to swipe
protocol Checkpoint {
    var type: CheckpointType { get }
    
    func validateAccess(entrant: Entrant) -> Bool
}


// Checkpoint for restricted areas
class RestrictedAreaCheckpoint: Checkpoint {
    var type: CheckpointType
    var area: Area
    var timeOfLastSwipe: Date
    
    
    init(aera: Area) {
        self.area = aera
        self.type = .restrictedArea
        self.timeOfLastSwipe = Date()
    }
    
    // Access validation.
    func validateAccess(entrant: Entrant) -> Bool {
        // Allows to test if two consecutive swipes are within 5 secondes. Access is refused in this case
        let now = Date()
        let secondsSinceLastSwipe = now - self.timeOfLastSwipe
        self.timeOfLastSwipe = now
        if entrant.areaAccess.contains(area) && secondsSinceLastSwipe < 5 {
            return true
        } else {
            return false
        }
    }
}

// Checkpoint for skip lines
class SkipTheLinesCheckpoint: Checkpoint {
    var type: CheckpointType
    
    init() {
        self.type = .skipTheLines
    }
    
    // Access validation.
    func validateAccess(entrant: Entrant) -> Bool {
        if entrant.rideAccess.contains(.skipTheLines) {
            return true
        } else {
            return false
        }
    }
}

// Register checkpoint
class RegisterCheckPoint: Checkpoint {
    
    var type: CheckpointType
    
    init() {
        self.type = .register
    }
    
    // Access validation.
    func validateAccess(entrant: Entrant) -> Bool {
        let discountOnFood = entrant.discountAccess[0].discount
        let discountOnMerchandise = entrant.discountAccess[1].discount
        if discountOnFood == 0.0 && discountOnMerchandise == 0.0 {
            return false
        } else {
            return true
        }
    }
}

