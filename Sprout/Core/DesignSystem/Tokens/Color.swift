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
    let accent = Color("AccentColor")
    let primary = Color("AppPrimary")
    let background = Color("Background")
    let border = Color("Border")
    let danger = Color("Danger")
    let primaryLight = Color("Primary Light")
    let secondary = Color("AppSecondary")
    let success = Color("Success")
    let surface = Color("Surface")
    let warning = Color("Warning")
}
