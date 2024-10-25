//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by David Denis on 10/25/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
