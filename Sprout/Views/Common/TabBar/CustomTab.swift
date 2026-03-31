//
//  CustomTab.swift
//  Sprout
//
//  Created by Adam Regan on 18/03/2026.
//

import SwiftUI

struct CustomTab: View {
    @Binding var selectedTab: Tabs
    var targetTab: Tabs

    var body: some View {
        Button {
            selectedTab = targetTab
        } label: {
            VStack {
                Image(systemName: targetTab.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(targetTab.displayName)
                    .font(.theme.footnote)
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(selectedTab == targetTab ? Color.theme.accent : Color.theme.secondary.opacity(0.8))
    }
}

#Preview {
    @Previewable @State var selectedTab: Tabs = .dashboard
    CustomTab(selectedTab: $selectedTab, targetTab: .dashboard)
}
