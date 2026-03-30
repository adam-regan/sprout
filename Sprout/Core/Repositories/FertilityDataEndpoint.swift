//
//  FertilityDataEndpoint.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

enum FertilityDataEndpoint: Sendable {
    case treatmentTrends
    case nhsFundingComparison
    case nhsCommissioning
    case birthRatesByAge
    case incidentsSummary
    case incidentsTimeline
    case keyStats

    case refTreatmentTypes
    case refRegions
    case refAgeGroups

    nonisolated var path: String {
        let base = "https://storage.googleapis.com/uk-fertility-gold-data/gold/exports"
        switch self {
        case .treatmentTrends:
            return "\(base)/treatment_trends/latest.json"
        case .refTreatmentTypes:
            return "\(base)/ref_treatment_types/latest.json"
        case .refRegions:
            return "\(base)/ref_regions/latest.json"
        case .refAgeGroups:
            return "\(base)/ref_age_groups/latest.json"
        case .nhsFundingComparison:
            return "\(base)/nhs_funding_comparison/latest.json"
        case .nhsCommissioning:
            return "\(base)/nhs_commissioning/latest.json"
        case .birthRatesByAge:
            return "\(base)/birth_rates_by_age/latest.json"
        case .incidentsSummary:
            return "\(base)/incidents_summary/latest.json"
        case .incidentsTimeline:
            return "\(base)/incidents_timeline/latest.json"
        case .keyStats:
            return "\(base)/key_stats/latest.json"
        }
    }

    nonisolated var cacheTimeout: TimeInterval {
        switch self {
        case .refTreatmentTypes, .refRegions, .refAgeGroups:
            return 86400
        default:
            return 3600
        }
    }
}
