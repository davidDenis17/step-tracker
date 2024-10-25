//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by David Denis on 10/25/24.
//

import Foundation

struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
