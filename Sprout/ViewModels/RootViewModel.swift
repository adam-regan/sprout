//
//  DashboardViewModel.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

@Observable
class RootViewModel {
    private let dataManager: DataManager
    var isLoading: Bool = true

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func loadingSequence() async {
        await dataManager.loadCriticalData()
        try? await Task.sleep(for: .seconds(3))
        isLoading = false
    }
}
