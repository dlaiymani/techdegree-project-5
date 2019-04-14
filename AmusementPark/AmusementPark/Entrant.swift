//
//  Entrant.swift
//  AmusementPark
//
//  Created by davidlaiymani on 12/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

enum Area: String {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess {
    case all
    case skipTheLines
}

enum DiscountAccess {
    case onFood(percentage: Double)
    case onMerchandise(percentage: Double)
    
    var discount: Double {
        switch self {
        case .onFood(let percentage): return percentage
        case .onMerchandise(let percentage): return percentage
        }
    }
}
enum EntrantType: String {
    case classic = "Adult"
    case vip = "VIP"
    case freeChild = "Child"
    case senior = "Senior"
    case seasonPass = "Season"
    case food = "Food"
    case ride = "Ride"
    case maintenance = "Maintenance"
    case contract = "Contract"
    case manager = "Manager"
    case vendor = "Vendor"
}

enum EntrantCategory: String {
    case guest = "Guest"
    case employee = "Employee"
    case manager = "Manager"
    case vendor = "Vendor"
}

protocol Entrant {
    var areaAccess: [Area] { get }
    var rideAccess: [RideAccess] { get }
    var discountAccess: [DiscountAccess] { get }
    var entrantCategory: EntrantCategory { get }
    var entrantType: EntrantType { get }
    var personalInformation: PersonalInformation? { get set }
    
    
    // Return a String for the personal information of an entrant
    func stringForPersonalInformation() -> String
    // Swipe at a checkpoint
    func swipe(at checkpoint: Checkpoint) -> Bool
}
