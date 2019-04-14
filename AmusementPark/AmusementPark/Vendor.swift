//
//  Vendor.swift
//  AmusementPark
//
//  Created by davidlaiymani on 12/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation



// Vendor class. Implements Entrant protocol
// Computed properties compute the different rights
class Vendor: Entrant {
    
    // MARK: - Properties
    var entrantCategory: EntrantCategory
    var entrantType: EntrantType
    var areaAccess: [Area]
    var rideAccess: [RideAccess] {
        return []
    }
    var discountAccess: [DiscountAccess] {
        return [DiscountAccess.onFood(percentage: 0), DiscountAccess.onMerchandise(percentage: 0)]
    }
    
    var personalInformation: PersonalInformation?
    var birthDate: Date
    var visitDate = Date()
    var company: Company
    
    
    // MARK: - Methods
    
    // Failable initializer in case of incomplete address
    init(birthDate: String, personalInformation: PersonalInformation, company: Company) throws {
        
        if birthDate == "" { // test if birth date is renseigned
            throw EntrantError.missingDateOfBirth
        }
        
        if let birthDate = birthDate.createDate() { // test if birth date  format is correct
            self.birthDate = birthDate
        } else {
            throw EntrantError.incorrectDate
        }
        
        if company.companyName != "" {
                self.company = company
        } else {
            throw EntrantError.missingCompany
        }
        
        if !personalInformation.validatePersonalInformationForVendor() {
            throw EntrantError.addressImcomplete
        }
        self.personalInformation = personalInformation
        self.entrantCategory = .manager
        self.entrantType = .manager
        self.areaAccess = company.authorizedAreaAccess()

    }
    
    // Swipe at a checkpoint
    func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    
    func stringForPersonalInformation() -> String {
        return "Vendor - \(self.entrantType) - Personal Information: \(self.personalInformation!.description)"
    }
    
}

