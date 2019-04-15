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
    var areaAccess: [Area]
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
    
    var personalInformation: PersonalInformation?
    // MARK: - Methods
    
    init(entrantType: EntrantType) {
        self.entrantType = entrantType
        self.entrantCategory = .guest
        switch self.entrantType {
        case .classic, .vip, .freeChild:
            areaAccess = [.amusement]
        default:
            areaAccess = []
        }
        
        self.personalInformation = nil
        
    }
    
    // Swipe at a checkpoint
    func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    func stringForPersonalInformation() -> String {
        return "Guest - \(self.entrantType) - No personal information to display"
    }
    
}

// SeniorGuest class: Guest + birth date + personal information
class SeniorGuest: Guest {
    var birthDate: Date
    
    // Failable initializer in case of incomplete address, birth date format incorrect and/or missing
    init(birthDate: String, personalInformation: PersonalInformation) throws {
        
        if birthDate == "" { // test if birth date is renseigned
            throw EntrantError.missingDateOfBirth
        }
        
        if let birthDate = birthDate.createDate() { // test if birth date  format is correct
            self.birthDate = birthDate
        } else {
            throw EntrantError.incorrectDate
        }
        
        if !personalInformation.validateName() {
            throw EntrantError.addressImcomplete
        }
        super.init(entrantType: EntrantType.senior)

        self.personalInformation = personalInformation

    }
    
    override func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
}

// SeniorGuest class: Guest + personal information
class SeasonPassGuest: Guest {
    
    // Failable initializer in case of incomplete address
    init(personalInformation: PersonalInformation) throws {
        
        if !personalInformation.validatePersonalInformation() {
            throw EntrantError.addressImcomplete
        }
        super.init(entrantType: EntrantType.seasonPass)

        self.personalInformation = personalInformation
        
    }
    
    override func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
}


// ChildGuest class: Guest + birth date
class ChildGuest: Guest {

    // MARK: - Properties
    
    var birthDate: Date
    
    
    // MARK: - Methods
    
    // Failable initializer in case of date of birth empty and child too old
    init(birthDate: String) throws {
        
        if birthDate == "" { // test if birth date is renseigned
            throw EntrantError.missingDateOfBirth
        }
        
        if let birthDate = birthDate.createDate() { // test if birth date is renseigned
            self.birthDate = birthDate
        } else {
            throw EntrantError.incorrectDate
        }
        super.init(entrantType: EntrantType.freeChild)
        
        // Test if the age is correct i.e <= 5
        guard validateDateOfBirth() else {
            throw EntrantError.tooOld
        }
        self.personalInformation = nil
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
        var returnString = "\(self.birthDate)"
        if self.birthDate.isBirthday() { // Add a message if it's the Entrant's birthday
            returnString += "Hey It's your birthday today: Happy Birthday 🎂 🎈"
        }
        return returnString
    }

}
