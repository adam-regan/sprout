//
//  DashboardViewModel.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

@Observable
class DashboardViewModel {
    private let repository: FertilityDataRepositoryProtocol

    var keyStats: Loadable<KeyStats> = .loading

    init(repository: FertilityDataRepositoryProtocol = FertilityDataRepository()) {
        self.repository = repository
    }

    func loadData() async {
        do {
            keyStats = try .loaded(await repository.getKeyStats())
        } catch {
            keyStats = .error(error)
        }
    }
}
