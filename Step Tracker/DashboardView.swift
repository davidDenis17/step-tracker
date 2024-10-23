//
//  DashboardView.swift
//  Step Tracker
//
//  Created by David Denis on 10/20/24.
//

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

                    VStack {
                        NavigationLink(value: selectedStat) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Label("Steps", systemImage: "figure.walk")
                                        .font(.title3.bold())
                                        .foregroundStyle(.pink)

                                    Text("Avg: 10K Steps")
                                        .font(.caption)
                                }
                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)

                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 150)

                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12).fill(
                            Color(.secondarySystemBackground)))

                    /// Bottom Chart

                    VStack(alignment: .leading) {

                        VStack(alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.pink)

                            Text("Last 28 days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 12)

                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 240)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12).fill(
                            Color(.secondarySystemBackground)))
                }

            }
            .padding()
            .task {
                // call functions to fetch data from Health App
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
