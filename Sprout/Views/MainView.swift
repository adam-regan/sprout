//
//  MainTabView.swift
//  Sprout
//
//  Created by Adam Regan on 18/03/2026.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Tabs = .dashboard
    var body: some View {
        VStack(spacing: 0) {
            Header(title: selectedTab.headerTitle)
            getTabContent()
                .frame(maxHeight: .infinity)
            CustomTabBar(selectedTab: $selectedTab)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    @ViewBuilder
    func getTabContent() -> some View {
        switch selectedTab {
        case .dashboard:
            Dashboard()
        case .trends:
            Text(selectedTab.headerTitle)
        case .clinics:
            Text(selectedTab.headerTitle)
        case .saved:
            Text(selectedTab.headerTitle)
        case .more:
            Text(selectedTab.headerTitle)
        }
    }
}

#Preview {
    MainView()
}
