//
//  DashboardCard.swift
//  Sprout
//
//  Created by Adam Regan on 19/03/2026.
//

import SwiftUI

struct DashboardCard: View {
    var stat: KeyStat
    var isHeroCard: Bool = false
    let cornerRadius = Radius.md
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stat.statValue)
                    .font(isHeroCard ? .title : .title2)
                    .fontWeight(.bold)
                Text(stat.displayLabel)
                    .font(.system(size: isHeroCard ? 12 : 11))
                    .opacity(0.8)
            }
            Spacer()
        }
        .padding(isHeroCard ? Spacing.lg : Spacing.md)
        .foregroundColor(Color.theme.secondary)
        .background(Color.theme.surface)
        .cornerRadius(cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 2)
                .foregroundStyle(Color.theme.border)
                .opacity(0.65)
        }
    }
}

#Preview {
    DashboardCard(stat: .init(statKey: "test", statValue: "100"))
        .padding()
}
