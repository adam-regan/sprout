# Fertility Data Repository Architecture

## Overview

This app uses the **Repository Pattern** to fetch data from UK Fertility Gold Data public storage endpoints.

## Architecture Layers

```
View → ViewModel → Repository → API Service
```

### 1. API Service Layer
- **`APIServiceProtocol`**: Generic networking protocol
- **`PublicStorageService`**: Concrete implementation for fetching JSON from URLs

### 2. Endpoint Configuration
- **`FertilityDataEndpoint`**: Enum containing all API endpoints
- Centralized URL management
- Different cache timeouts for reference vs. regular data

### 3. Repository Layer
- **`FertilityDataRepositoryProtocol`**: Protocol defining all data operations
- **`FertilityDataRepository`**: Actor-based implementation with automatic caching
- Handles all network requests and caching logic

### 4. ViewModel Layer
- **Domain-specific ViewModels** (e.g., `DashboardViewModel`, `TrendsViewModel`)
- Manages UI state (`isLoading`, `errorMessage`)
- Uses Swift Concurrency for async operations

## Available Endpoints

### Main Data
- `getTreatmentTrends()` - Treatment trends data
- `getNHSFundingComparison()` - NHS funding comparison
- `getNHSCommissioning()` - NHS commissioning data
- `getBirthRatesByAge()` - Birth rates by age group
- `getIncidentsSummary()` - Incidents summary
- `getIncidentsTimeline()` - Incidents timeline
- `getKeyStats()` - Key statistics

### Reference Data
- `getRefTreatmentTypes()` - Treatment types reference (cached 24h)
- `getRefRegions()` - Regions reference (cached 24h)
- `getRefAgeGroups()` - Age groups reference (cached 24h)

## Usage Example

### In a View

```swift
import SwiftUI

struct TrendsView: View {
    @State private var viewModel = TrendsViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading trends...")
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(
                    "Unable to Load",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else if let trends = viewModel.treatmentTrends {
                // Display your data
                Text("Trends loaded!")
            }
        }
        .task {
            await viewModel.loadData()
        }
        .refreshable {
            await viewModel.loadData()
        }
    }
}
```

### Loading Multiple Endpoints in Parallel

```swift
func loadData() async {
    do {
        // These run concurrently!
        async let stats = repository.getKeyStats()
        async let incidents = repository.getIncidentsSummary()
        async let funding = repository.getNHSFundingComparison()
        
        (keyStats, incidentsSummary, nhsFunding) = try await (stats, incidents, funding)
    } catch {
        errorMessage = error.localizedDescription
    }
}
```

### Cache Management

```swift
// Clear all cache
await repository.clearCache()

// Clear specific endpoint cache
await repository.clearCache(for: .keyStats)
```

## Caching Strategy

- **Reference data**: 24 hours (rarely changes)
- **Regular data**: 1 hour (balances freshness with API usage)
- Uses actor for thread-safe cache management
- Automatic cache invalidation based on timestamps

## Testing

Because we use protocols, testing is straightforward:

```swift
class MockRepository: FertilityDataRepositoryProtocol {
    var mockKeyStats: KeyStats?
    var shouldThrowError = false
    
    func getKeyStats() async throws -> KeyStats {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockKeyStats ?? KeyStats()
    }
    
    // Implement other methods...
}

// In tests
let mockRepo = MockRepository()
mockRepo.mockKeyStats = KeyStats(/* test data */)
let viewModel = DashboardViewModel(repository: mockRepo)
```

## Next Steps

1. **Inspect actual JSON responses** from the endpoints
2. **Update model structs** in `FertilityDataModels.swift` with real fields
3. **Create views** that use the ViewModels
4. **Add query parameters** to endpoints if needed (see "Adding Query Parameters" below)

## Adding Query Parameters

If you need to query endpoints with parameters later:

```swift
enum FertilityDataEndpoint {
    case treatmentTrends(year: Int? = nil, region: String? = nil)
    
    var path: String {
        let base = "https://storage.googleapis.com/uk-fertility-gold-data/gold/exports"
        switch self {
        case .treatmentTrends(let year, let region):
            var components = URLComponents(string: "\(base)/treatment_trends/latest.json")!
            var queryItems: [URLQueryItem] = []
            
            if let year = year {
                queryItems.append(URLQueryItem(name: "year", value: "\(year)"))
            }
            if let region = region {
                queryItems.append(URLQueryItem(name: "region", value: region))
            }
            
            if !queryItems.isEmpty {
                components.queryItems = queryItems
            }
            
            return components.url?.absoluteString ?? "\(base)/treatment_trends/latest.json"
        }
    }
}
```

## File Structure

```
Sprout/
├── Models/
│   └── FertilityDataModels.swift
├── Services/
│   ├── APIServiceProtocol.swift
│   └── FertilityDataEndpoint.swift
├── Repositories/
│   ├── FertilityDataRepositoryProtocol.swift
│   └── FertilityDataRepository.swift
├── ViewModels/
│   ├── DashboardViewModel.swift
│   └── TrendsViewModel.swift
└── Views/
    ├── MainView.swift
    ├── Dashboard.swift
    └── TrendsView.swift
```
