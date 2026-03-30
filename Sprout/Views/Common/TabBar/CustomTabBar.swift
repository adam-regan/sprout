//
//  CustomTabBar.swift
//  Sprout
//
//  Created by Adam Regan on 18/03/2026.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                CustomTab(selectedTab: $selectedTab, targetTab: tab)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var selectedTab: Tabs = .dashboard
    CustomTabBar(selectedTab: $selectedTab)
}
