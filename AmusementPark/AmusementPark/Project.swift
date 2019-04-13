//
//  Project.swift
//  AmusementPark
//
//  Created by davidlaiymani on 13/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation


class Project {
    var projectNumber: String
    
    init(projectNumber: String) {
        self.projectNumber = projectNumber
    }
    
    func authorizedAreaAccess() -> [Area] {
        var areas = [Area]()
        switch self.projectNumber {
        case "1001":
            areas = [.amusement, .rideControl]
        case "1002":
            areas = [.amusement, .rideControl, .maintenance]
        case "1003":
            areas = [.amusement, .kitchen, .maintenance, .rideControl, .office]
        case "2001":
            areas = [.office]
        case "2002":
            areas = [.kitchen, .maintenance]
        default:
            areas = []
        }
        return areas
    }
}
