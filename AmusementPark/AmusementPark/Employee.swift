//
//  Employee.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation


// Employee class. Implements Entrant protocol
// Computed properties compute the different rights depending of the entrant type (food, ride...)
class Employee: Entrant {
    
    // MARK: - Properties
    
    var entrantType: EntrantType
    var entrantCategory: EntrantCategory
    var areaAccess: [Area] {
        switch self.entrantType {
        case .food: return [.amusement, .kitchen]
        case .ride: return [.amusement, .rideControl]
        case .maintenance: return [.amusement, .kitchen, .rideControl, .maintenance]
        case .contract: return [.amusement, .kitchen]
        default: return []
            
        }
    }
    var rideAccess: [RideAccess] {
        return [RideAccess.all]
    }
    var discountAccess: [DiscountAccess] {
        if self.entrantType == .contract {
            return [DiscountAccess.onFood(percentage: 0), DiscountAccess.onMerchandise(percentage: 0)]
        } else {
            return [DiscountAccess.onFood(percentage: 15), DiscountAccess.onMerchandise(percentage: 25)]
        }
    }

    var personalInformation: PersonalInformation?
    
    // MARK: - Methods
    
    // Failable initializer in case of incomplete address
    init(entrantType: EntrantType, personalInformation: PersonalInformation) throws {
        self.entrantCategory = .employee
        self.entrantType = entrantType
        
        if !personalInformation.validatePersonalInformation() {
            throw EntrantError.addressImcomplete
        }
        
        self.personalInformation = personalInformation
    }
    
    // Swipe at a checkpoint
    func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    func stringForPersonalInformation() -> String {
        return "Employee - \(self.entrantType) - Personal Information: \(self.personalInformation!.description)"
    }
    
}
