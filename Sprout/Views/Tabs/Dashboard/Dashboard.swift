//
//  Dashboard.swift
//  Sprout
//
//  Created by Adam Regan on 19/03/2026.
//

import SwiftUI

struct Dashboard: View {
    @State private var viewModel: DashboardViewModel = .init()
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            switch viewModel.keyStats {
            case .loading, .error:
                Text("Loading...")
            case let .loaded(keyStats):
                DashboardCard(stat: KeyStat(statKey: "Total births", statValue: "28000"), isHeroCard: true)
                LazyVGrid(columns: columns) {
                    ForEach(keyStats.data, id: \.self) { stat in
                        DashboardCard(stat: stat)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    Dashboard()
        .padding(.horizontal)
}
