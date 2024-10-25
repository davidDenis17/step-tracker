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
    
    
}
