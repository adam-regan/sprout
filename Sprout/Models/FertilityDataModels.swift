//
//  FertilityDataModels.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

struct APIResponse<T: Decodable>: nonisolated Decodable {
    let entity: String
    let exportedAt: String
    let rowCount: Int
    let data: [T]
}

struct KeyStat: nonisolated Decodable, Hashable {
    let statKey: String
    let statValue: String
}

extension KeyStat {
    var displayLabel: String {
        switch statKey {
        case "total_cycles":
            return "Total Treatment Cycles"
        case "success_rate":
            return "Success Rate"
        case "live_births":
            return "Live Births"
        case "avg_age":
            return "Average Patient Age"
        case "clinics_count":
            return "Licensed Clinics"
        default:
            // Fallback: convert snake_case to Title Case
            return statKey
                .replacingOccurrences(of: "_", with: " ")
                .capitalized
        }
    }
}

typealias KeyStats = APIResponse<KeyStat>

struct TreatmentTrends: nonisolated Decodable {
    var _placeholder: String? = nil
}

struct NHSFundingComparison: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct NHSCommissioning: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct BirthRatesByAge: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct IncidentsSummary: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct IncidentsTimeline: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct RefTreatmentTypes: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct RefRegions: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}

struct RefAgeGroups: nonisolated Decodable {
    // Add actual fields once you inspect the JSON
}
