//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by David Denis on 10/25/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date      // x-axis
    let value: Double   // y-axis
    
    static var mockData: [HealthMetric] {
        var array: [HealthMetric] = []
        for i in 0..<28 {
            array.append(HealthMetric(date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!, value: Double.random(in: 4_000...15_000)))
        }
        return array
    }
}
