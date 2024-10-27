//
//  DashboardView.swift
//  Step Tracker
//
//  Created by David Denis on 10/20/24.
//

import Charts
import SwiftUI

// Iterate through the cases
enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    var id: Self { self }

    var title: String {
        switch self {
        case .steps: return "Steps"
        case .weight: return "Weight"
        // case .calories: return "Calories"
        }
    }
}

struct DashboardView: View {

    // HealthKit Manager
    @Environment(HealthKitManager.self) private var hkManager

    // used to store small stuff in app
    @AppStorage("hasSeenPermissionPriming") private
        var hasSeenPermissionPriming: Bool = false

    // sheet
    @State private var isShowingPermissionPrimingSheet: Bool = false

    @State private var selectedStat: HealthMetricContext = .steps
    var isSteps: Bool { selectedStat == .steps }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) {
                            Text($0.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    switch selectedStat {
                        case .steps:
                        StepBarChart(selectedStat: selectedStat, chartData: hkManager.stepData)
                        StepPieChart(chartData: ChartMath.averageWeekdayCount(for: hkManager.stepData))
                        
                        case .weight:
                        WeightLineChart(selectedStat: selectedStat, chartData: hkManager.weightData)
                    }
                    
                    
                    
                    /// Bottom Chart
                    
                    
                }
            }
            .padding()
            .task {
                // call functions to fetch data from Health App
                await hkManager.fetchStepCount()
                await hkManager.fetchWeight()
                ChartMath.averageDailyWeightDiff(for: hkManager.weightDiffData)
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(
                isPresented: $isShowingPermissionPrimingSheet,
                onDismiss: {
                    //fetch health data
                },
                content: {
                    HealthKitPermissionPrimingView(
                        hasSeen: $hasSeenPermissionPriming)
                })

        }
        .tint(isSteps ? .pink : .indigo)
    }

    
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
