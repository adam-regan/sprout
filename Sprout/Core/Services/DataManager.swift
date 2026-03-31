//
//  DataManager.swift
//  Sprout
//
//  Created by Adam Regan on 30/03/2026.
//

import SwiftUI

@Observable
@MainActor
class DataManager {
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    var loadingState: LoadingState = .idle
    
    var keyStats: KeyStats?
    var treatmentTrends: TreatmentTrends?
    var nhsFundingComparison: NHSFundingComparison?
    var nhsCommissioning: NHSCommissioning?
    var birthRatesByAge: BirthRatesByAge?
    var incidentsSummary: IncidentsSummary?
    var incidentsTimeline: IncidentsTimeline?
    
    var refTreatmentTypes: RefTreatmentTypes?
    var refRegions: RefRegions?
    var refAgeGroups: RefAgeGroups?
    

    private let repository: FertilityDataRepositoryProtocol
    
    init(repository: FertilityDataRepositoryProtocol) {
        self.repository = repository
    }

    init() {
        self.repository = FertilityDataRepository()
    }
    
    
    func loadCriticalData() async {
        guard loadingState == LoadingState.idle else { return }
        
        loadingState = .loading
        
        do {
            keyStats = try await repository.getKeyStats()
            
            Task {
                await prefetchRemainingData()
            }
            
            loadingState = .loaded
        } catch {
            loadingState = .error(error.localizedDescription)
        }
    }
    
    private func prefetchRemainingData() async {
        async let trends = loadEndpoint { try await self.repository.getTreatmentTrends() }
        async let funding = loadEndpoint { try await self.repository.getNHSFundingComparison() }
        async let commissioning = loadEndpoint { try await self.repository.getNHSCommissioning() }
        async let birthRates = loadEndpoint { try await self.repository.getBirthRatesByAge() }
        async let incSummary = loadEndpoint { try await self.repository.getIncidentsSummary() }
        async let incTimeline = loadEndpoint { try await self.repository.getIncidentsTimeline() }
        async let refTypes = loadEndpoint { try await self.repository.getRefTreatmentTypes() }
        async let refRegs = loadEndpoint { try await self.repository.getRefRegions() }
        async let refAges = loadEndpoint { try await self.repository.getRefAgeGroups() }
        
        let results = await (trends, funding, commissioning, birthRates, incSummary, incTimeline, refTypes, refRegs, refAges)
        
        treatmentTrends = results.0
        nhsFundingComparison = results.1
        nhsCommissioning = results.2
        birthRatesByAge = results.3
        incidentsSummary = results.4
        incidentsTimeline = results.5
        refTreatmentTypes = results.6
        refRegions = results.7
        refAgeGroups = results.8
        
    }
    
    private func loadEndpoint<T>(_ operation: @escaping () async throws -> T) async -> T? {
        do {
            return try await operation()
        } catch {
            return nil
        }
    }
    
    func refresh() async {
        loadingState = .idle
        await loadCriticalData()
    }
}
