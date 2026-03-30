//
//  Tabs.swift
//  Sprout
//
//  Created by Adam Regan on 18/03/2026.
//

enum Tabs: String, CaseIterable {
    case dashboard, trends, clinics, saved, more

    var displayName: String {
        rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }

    var systemImage: String {
        switch self {
        case .dashboard:
            return "house.fill"
        case .trends:
            return "chart.bar"
        case .clinics:
            return "magnifyingglass"
        case .saved:
            return "heart"
        case .more:
            return "ellipsis"
        }
    }

    var headerTitle: String {
        switch self {
        case .dashboard:
            return "UK Fertility"
        case .trends:
            return "Trends"
        case .clinics:
            return "Search Clinics"
        case .saved:
            return "Saved"
        case .more:
            return "More"
        }
    }
}
