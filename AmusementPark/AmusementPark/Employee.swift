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
    var areaAccess: [Area]
    
    var rideAccess: [RideAccess] {
        if self.entrantType == .contract {
            return []
        } else {
            return [RideAccess.all]
        }
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
        
        switch self.entrantType {
        case .food:
            areaAccess = [.amusement, .kitchen]
        case .ride:
            areaAccess = [.amusement, .rideControl]
        case .maintenance:
            areaAccess = [.amusement, .kitchen, .rideControl, .maintenance]
        default:
            areaAccess = []
            
        }
        
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

class ContractEmployee: Employee {
    var project: Project
    
    init(project: Project, personalInformation: PersonalInformation) throws {
        
        self.project = project

        try! super.init(entrantType: .contract, personalInformation: personalInformation)
        self.areaAccess = project.authorizedAreaAccess()
        
        if !personalInformation.validatePersonalInformation() {
            throw EntrantError.addressImcomplete
        }
        
        self.personalInformation = personalInformation
        
    }
}
