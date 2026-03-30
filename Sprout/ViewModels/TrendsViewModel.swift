//
//  TrendsViewModel.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

@Observable
class TrendsViewModel {
    private let repository: FertilityDataRepositoryProtocol
    
    // Data properties
    var treatmentTrends: TreatmentTrends?
    var birthRates: BirthRatesByAge?
    
    // UI state
    var isLoading = false
    var errorMessage: String?
    
    init(repository: FertilityDataRepositoryProtocol = FertilityDataRepository()) {
        self.repository = repository
    }
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Load multiple endpoints in parallel
            async let trends = repository.getTreatmentTrends()
            async let rates = repository.getBirthRatesByAge()
            
            // Wait for both to complete
            (treatmentTrends, birthRates) = try await (trends, rates)
        } catch {
            errorMessage = "Failed to load trends data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
