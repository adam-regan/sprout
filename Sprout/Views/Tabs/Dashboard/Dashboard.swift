//
//  Dashboard.swift
//  Sprout
//
//  Created by Adam Regan on 19/03/2026.
//

import SwiftUI

struct Dashboard: View {
    @Environment(DataManager.self) private var dataManager

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            switch dataManager.loadingState {
            case .idle, .loading:
                VStack(spacing: 16) {
                    ProgressView("Loading data...")
                }
                .frame(maxHeight: .infinity)

            case .error(let message):
                ContentUnavailableView(
                    "Unable to Load Data",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )

            case .loaded:
                if let keyStats = dataManager.keyStats {
                    let (totalBirthsStat, otherStats): (KeyStat?, [KeyStat]) = keyStats.data.reduce(into: (nil, [])) { result, stat in
                        if stat.statKey == "ivf_babies_born" {
                            result.0 = stat
                        } else {
                            result.1.append(stat)
                        }
                    }
                    if let totalBirths = totalBirthsStat {
                        DashboardCard(
                            stat: totalBirths,
                            isHeroCard: true
                        )
                    }

                    LazyVGrid(columns: columns) {
                        ForEach(otherStats, id: \.self) { stat in
                            if stat.displayLabel != nil {
                                DashboardCard(stat: stat)
                            }
                        }
                    }
                }
            }
        }

        .refreshable {
            await dataManager.refresh()
        }
    }
}

#Preview {
    let dataManager = DataManager()
    Dashboard()
        .environment(dataManager)
        .padding(.horizontal)
        .task {
            await dataManager.loadCriticalData()
        }
}
