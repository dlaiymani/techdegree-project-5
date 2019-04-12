//
//  Errors.swift
//  AmusementPark
//
//  Created by davidlaiymani on 01/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

enum EntrantError: Error {
    case missingDateOfBirth
    case tooOld
    case addressImcomplete
}
