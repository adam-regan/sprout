//
//  FertilityDataRepositoryProtocol.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

protocol FertilityDataRepositoryProtocol {
    func getTreatmentTrends() async throws -> TreatmentTrends
    func getNHSFundingComparison() async throws -> NHSFundingComparison
    func getNHSCommissioning() async throws -> NHSCommissioning
    func getBirthRatesByAge() async throws -> BirthRatesByAge
    func getIncidentsSummary() async throws -> IncidentsSummary
    func getIncidentsTimeline() async throws -> IncidentsTimeline
    func getKeyStats() async throws -> KeyStats
    
    func getRefTreatmentTypes() async throws -> RefTreatmentTypes
    func getRefRegions() async throws -> RefRegions
    func getRefAgeGroups() async throws -> RefAgeGroups
}
