//
//  Company.swift
//  AmusementPark
//
//  Created by davidlaiymani on 14/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

class Company {
    var companyName: String
    
    init(companyName: String) {
        self.companyName = companyName
    }
    
    func authorizedAreaAccess() -> [Area] {
        var areas = [Area]()
        switch self.companyName {
        case "Acme":
            areas = [.kitchen]
        case "Orkin":
            areas = [.amusement, .rideControl, .kitchen]
        case "Fedex":
            areas = [.maintenance]
        case "NW Electrical":
            areas = [.amusement, .rideControl, .kitchen, .maintenance,.office]
        default:
            areas = []
        }
        return areas
    }
}
