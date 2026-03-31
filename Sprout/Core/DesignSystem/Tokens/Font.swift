//
//  Font.swift
//  Sprout
//
//  Created by Adam Regan on 30/03/2026.
//

import SwiftUI

extension Font {
    static let theme = FontTheme()

    struct FontTheme {
        let largeTitle: Font = .custom("Dash Practice", size: 34)
        let title: Font = .custom("Dash Practice", size: 28)
        let title2: Font = .custom("Dash Practice", size: 22)
        let title3: Font = .custom("Dash Practice", size: 20)
        let headline: Font = .custom("Dash Practice", size: 17).weight(.semibold)
        let body: Font = .custom("Dash Practice", size: 17)
        let callout: Font = .custom("Dash Practice", size: 16)
        let subheadline: Font = .custom("Dash Practice", size: 15)
        let footnote: Font = .custom("Dash Practice", size: 13)
        let caption: Font = .custom("Dash Practice", size: 12)
        let caption2: Font = .custom("Dash Practice", size: 11)
    }
}
