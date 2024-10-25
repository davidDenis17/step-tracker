//
//  ChartMath.swift
//  Step Tracker
//
//  Created by David Denis on 10/25/24.
//

import Foundation
import Algorithms

struct ChartMathTests {
    
    static func averageWeekdayCount(for metric: [HealthMetric]) -> [WeekdayChartData] {
        
        // sorting by the weekday INTs (smallest is 1 (Sunday)) extension to Date
        let sortedByWeekday = metric.sorted { $0.date.weekdayInt < $1.date.weekdayInt }
        
        // chunks the orgininal array into 7 smaller arrays containing the steps of each day
        let weekdayArray = sortedByWeekday.chunked { $0.date.weekdayInt == $1.date.weekdayInt}
        
        var weekdayChartData: [WeekdayChartData] = []
        
        for array in weekdayArray {
            guard let firstValue = array.first else { continue }
            
            // get total by summing the array
            let total = array.reduce(0) { $0 + $1.value }
            let avgSteps = total / Double(array.count)
            
            weekdayChartData.append(.init(date: firstValue.date, value: avgSteps))
            
            
        }
        
        
        return weekdayChartData
        
    }
}
