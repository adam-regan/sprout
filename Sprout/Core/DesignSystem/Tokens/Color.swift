//
//  Color.swift
//  Sprout
//
//  Created by Adam Regan on 26/03/2026.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("Accent")
    let primary = Color("PrimaryColor")
    let background = Color("Background")
    let border = Color("Border")
    let danger = Color("Danger")
    let primaryLight = Color("Primary Light")
    let secondary = Color("SecondaryColor")
    let success = Color("Success")
    let surface = Color("Surface")
    let warning = Color("Warning")
}
