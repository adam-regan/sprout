//
//  SproutApp.swift
//  Sprout
//
//  Created by Adam Regan on 18/03/2026.
//

import SwiftUI

@main
struct SproutApp: App {
    @State private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(dataManager)
        }
    }
}
