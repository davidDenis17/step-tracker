//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by David Denis on 10/22/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
    
}
