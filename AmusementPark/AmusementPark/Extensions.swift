//
//  DateExtension.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation


extension Date {
    // Allow to compute the difference between two dates
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    // return true if today is same day and month as date
    func isBirthday() -> Bool {
        let calendar = Calendar.current
        let birthDay = calendar.dateComponents([.day], from: self)
        let birthMonth = calendar.dateComponents([.month], from: self)
        let today = calendar.dateComponents([.day], from: Date())
        let thisMonth = calendar.dateComponents([.month], from: Date())
        return birthDay == today && birthMonth == thisMonth
    }
}


extension String {
    // Create a date from a String
    func createDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self) ?? nil
    }
}
    
