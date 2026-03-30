//
//  Header.swift
//  Sprout
//
//  Created by Adam Regan on 18/03/2026.
//

import SwiftUI

struct Header: View {
    var title: String
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 24))
                .tracking(1.1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                print("Profile Button Clicked")
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40, weight: .medium))
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom)
        }
        .foregroundColor(.theme.primary)
    }
}

#Preview {
    Header(title: "Home")
}
