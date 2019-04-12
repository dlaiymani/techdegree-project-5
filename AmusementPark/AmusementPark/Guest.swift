//
//  Guest.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

// Guest class. Implements Entrant protocol.
// Computed properties compute the different rights depending of the entrant type (vip, classic...)
class Guest: Entrant {
    
    // MARK: - Properties

    var entrantType: EntrantType
    var entrantCategory: EntrantCategory
    var areaAccess: [Area] {
        switch self.entrantType {
        case .classic: return [.amusement]
        case .vip: return [.amusement]
        case .freeChild: return [.amusement]
        default: return []
        }
    }
    var rideAccess: [RideAccess] {
        switch self.entrantType {
        case .classic: return [.all]
        case .vip: return [.all, .skipTheLines]
        case .freeChild: return [.all]
        default: return []
            
        }
    }
    var discountAccess: [DiscountAccess] {
        switch self.entrantType {
        case .classic: return [.onFood(percentage: 0), .onMerchandise(percentage: 0)]
        case .vip: return [.onFood(percentage: 10), .onMerchandise(percentage: 20)]
        case .freeChild: return [.onFood(percentage: 0), .onMerchandise(percentage: 0)]
        default: return []
            
        }
    }
    
    // MARK: - Methods
    
    init(entrantType: EntrantType) {
        self.entrantType = entrantType
        self.entrantCategory = .guest
    }
    
    // Swipe at a checkpoint
    func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    func stringForPersonalInformation() -> String {
        return "Guest - \(self.entrantType) - No personal information to display"
    }
}

// ChildGuest class, inherits from Guest
class ChildGuest: Guest {

    // MARK: - Properties
    
    var birthDate: Date
    
    
    // MARK: - Methods

    // Failable initializer in case of date of birth empty and child too old
    init(birthDate: String) throws {
        
        if let birthDate = birthDate.createDate() { // test if birth date is renseigned
            self.birthDate = birthDate
        } else {
            throw EntrantError.missingDateOfBirth
        }
        super.init(entrantType: EntrantType.freeChild)

        // Test if the age is correct i.e <= 5
        guard validateDateOfBirth() else {
            throw EntrantError.tooOld
        }
    }
    
    // Test if the child is too old or not
    func validateDateOfBirth() -> Bool {
        let now = Date()
        let interval = now.timeIntervalSince(self.birthDate)
        if  interval/31536000 >= 5 { // Must exist better solution
            return false
        } else {
            return true
        }
    }
    
    override func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    
    override func stringForPersonalInformation() -> String {
        var returnString = "Guest - child - Personal Information: Date of birth: \(self.birthDate). "
        if self.birthDate.isBirthday() { // Add a message if it's the Entrant's birthday
            returnString += "Hey It's your birthday today: Happy Birthday 🎂 🎈"
        }
        return returnString
    }
}
