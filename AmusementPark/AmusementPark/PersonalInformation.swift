//
//  PersonalInformation.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

struct PersonalInformation: CustomStringConvertible  {
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    
    var description: String {
        return "\(firstName) -\(firstName). Address: \(streetAddress), \(zipCode), \(city) - \(state)"
    }
    
    func validatePersonalInformation() -> Bool {
        if firstName == "" || lastName == "" || streetAddress == "" || city == "" || state == "" || zipCode == "" {
            return false
        } else {
            return true
        }
    }
}
