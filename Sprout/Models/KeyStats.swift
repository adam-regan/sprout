//
//  KeyStats.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

struct KeyStat: nonisolated Decodable, Hashable {
    let statKey: String
    let statValue: String
}

extension KeyStat {
    var displayLabel: String? {
        switch statKey {
        case "ivf_babies_born":
            return "Total Births"
        case "nhs_funded_pct":
            return "NHS Funded %"
        case "ivf_cycles":
            return "Total IVF Cycles"
        case "patients_treated":
            return "Treated Patients"
        case "licensed_clinics":
            return "Licensed Clinics"
        case "egg_freezing_cycles":
            return "Egg Freezing Cycles"
        case "new_donors":
            return "New Donors"
        case "data_years_range":
            return "Data Years"
        case "ivf_births_pct_of_uk":
            return "IVF Births %"
        default:
            return nil
        }
    }

    var formattedValue: String {
        switch statKey {
        case "nhs_funded_pct", "ivf_births_pct_of_uk":
            return "\(statValue)%"
        default:
            return statValue
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
