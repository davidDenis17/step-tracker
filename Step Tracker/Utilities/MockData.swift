//
//  MockData.swift
//  Step Tracker
//
//  Created by David Denis on 10/27/24.
//

import Foundation

struct MockData {
    static var steps: [HealthMetric] {
        var array: [HealthMetric] = []
        for i in 0..<28 {
            array.append(HealthMetric(date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!, value: Double.random(in: 4_000...15_000)))
        }
        return array
    }

    static var weights: [HealthMetric] {
        var array: [HealthMetric] = []
        for i in 0..<28 {
            array.append(HealthMetric(date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!, value: .random(in: (160 + Double(i/3)...165 + Double(i/3)))))
        }
        return array
    }
}
