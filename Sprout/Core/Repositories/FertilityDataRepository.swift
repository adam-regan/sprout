//
//  FertilityDataRepository.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

actor FertilityDataRepository: FertilityDataRepositoryProtocol {
    private let apiService: APIServiceProtocol
    private var cache: [String: CacheEntry] = [:]
    private var ongoingRequests: [String: Task<any Decodable, Error>] = [:]
    
    struct CacheEntry {
        let data: any Decodable
        let timestamp: Date
        
        func isValid(timeout: TimeInterval) -> Bool {
            Date().timeIntervalSince(timestamp) < timeout
        }
    }
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    init() {
        apiService = PublicAPIService()
    }
    
    // MARK: - Private Helper
    
    private func fetchWithCache<T: Decodable>(
        endpoint: FertilityDataEndpoint
    ) async throws -> T {
        let key = endpoint.path
        
        // Check cache first
        if let entry = cache[key],
           entry.isValid(timeout: endpoint.cacheTimeout),
           let cached = entry.data as? T
        {
            return cached
        }
        
        // Check if request is already in progress
        if let existingTask = ongoingRequests[key] {
            // Wait for the existing request to complete
            let result = try await existingTask.value
            guard let typedResult = result as? T else {
                throw URLError(.cannotDecodeContentData)
            }
            return typedResult
        }
        
        // Create new request task
        let task = Task<any Decodable, Error> {
            let data: T = try await apiService.fetch(from: endpoint.path)
            
            // Update cache
            cache[key] = CacheEntry(data: data, timestamp: Date())
            
            // Remove from ongoing requests
            ongoingRequests.removeValue(forKey: key)
            
            return data
        }
        
        // Store the ongoing task
        ongoingRequests[key] = task
        
        // Wait for result
        let result = try await task.value
        guard let typedResult = result as? T else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return typedResult
    }
    
    func getTreatmentTrends() async throws -> TreatmentTrends {
        try await fetchWithCache(endpoint: .treatmentTrends)
    }
    
    func getNHSFundingComparison() async throws -> NHSFundingComparison {
        try await fetchWithCache(endpoint: .nhsFundingComparison)
    }
    
    func getNHSCommissioning() async throws -> NHSCommissioning {
        try await fetchWithCache(endpoint: .nhsCommissioning)
    }
    
    func getBirthRatesByAge() async throws -> BirthRatesByAge {
        try await fetchWithCache(endpoint: .birthRatesByAge)
    }
    
    func getIncidentsSummary() async throws -> IncidentsSummary {
        try await fetchWithCache(endpoint: .incidentsSummary)
    }
    
    func getIncidentsTimeline() async throws -> IncidentsTimeline {
        try await fetchWithCache(endpoint: .incidentsTimeline)
    }
    
    func getKeyStats() async throws -> KeyStats {
        try await fetchWithCache(endpoint: .keyStats)
    }
    
    func getRefTreatmentTypes() async throws -> RefTreatmentTypes {
        try await fetchWithCache(endpoint: .refTreatmentTypes)
    }
    
    func getRefRegions() async throws -> RefRegions {
        try await fetchWithCache(endpoint: .refRegions)
    }
    
    func getRefAgeGroups() async throws -> RefAgeGroups {
        try await fetchWithCache(endpoint: .refAgeGroups)
    }
        
    func clearCache() {
        cache.removeAll()
    }
    
    func clearCache(for endpoint: FertilityDataEndpoint) {
        cache.removeValue(forKey: endpoint.path)
    }
    
    func reset() {
        ongoingRequests.values.forEach { $0.cancel() }
        ongoingRequests.removeAll()
        cache.removeAll()
    }
}
