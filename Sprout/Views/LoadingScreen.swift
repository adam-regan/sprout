//
//  LoadingScreen.swift
//  Sprout
//
//  Created by Adam Regan on 30/03/2026.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight: 150)
                Text("Sprout")
                    .font(.theme.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.theme.primary)
                Text("FERTILITY CLINIC FINDER")
                    .font(.theme.headline)
                    .foregroundColor(.theme.secondary.opacity(0.5))
                    .offset(y: 4)
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
