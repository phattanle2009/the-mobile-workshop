//
//  AppColors.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit

extension UIColor {
    // MARK: Primary Palette (Ultramarine Blue)
    static let primary50 = UIColor(hex: "#E8E9FC")
    static let primary100 = UIColor(hex: "#D1D3FA")
    static let primary200 = UIColor(hex: "#A3A7F5")
    static let primary300 = UIColor(hex: "#757BF0") // Note: corrected typo Fo -> F0
    static let primary400 = UIColor(hex: "#474FEB")
    static let primary500 = UIColor(hex: "#4A52EB") // Brand color (Your #4A52EB-500)
    static let primary600 = UIColor(hex: "#141CB8")
    static let primary700 = UIColor(hex: "#0F158A")
    static let primary800 = UIColor(hex: "#0A0E5C")
    static let primary900 = UIColor(hex: "#05072E")
    static let primary950 = UIColor(hex: "#030417")

    // MARK: Accent Palette (Mindaro)
    static let accent50 = UIColor(hex: "#F7FDE7")
    static let accent100 = UIColor(hex: "#EFFCCF")
    static let accent200 = UIColor(hex: "#DFF8A0")
    static let accent300 = UIColor(hex: "#CFF570")
    static let accent400 = UIColor(hex: "#BFF141")
    static let accent500 = UIColor(hex: "#D1F577") // Accent brand color (Your #D1F577-500)

    // MARK: Neutral Palette
    static let neutral50 = UIColor(hex: "#F1F1F3")
    static let neutral100 = UIColor(hex: "#E4E4E7")
    static let neutral200 = UIColor(hex: "#C8C8D0")
    static let neutral300 = UIColor(hex: "#ADADB8")
    static let neutral400 = UIColor(hex: "#9191A1")
    static let neutral500 = UIColor(hex: "#5E5E6E")
    static let neutral600 = UIColor(hex: "#474752")
    static let neutral700 = UIColor(hex: "#2F2F37")
    static let neutral800 = UIColor(hex: "#191910")
    static let neutral900 = UIColor(hex: "#191910")

    // MARK: Background Palette
    static let bg1 = UIColor(hex: "#F3F6FF")
    static let bg2 = UIColor(hex: "#EECCFF")
    static let bg3 = UIColor(hex: "#0F0EFF")
    static let bg4 = UIColor(hex: "#141CB8") // Using Primary 600 as a dark background option

    // MARK: Semantic Colors
    static let error = UIColor(hex: "#E53935")
    static let warning = UIColor(hex: "#FFB300")
    static let success = UIColor(hex: "#4CAF50")

    // MARK: App Specific Roles (mapping to the palette)
    static let appBackground = UIColor.neutral50
    static let buttonPrimary = UIColor.primary500
    static let buttonSecondary = UIColor.accent500
    static let textPrimary = UIColor.neutral900
    static let textSecondary = UIColor.neutral700
    static let textOnButton = UIColor.white
    static let cellBackground = UIColor.white
    static let clickState = UIColor.primary700
}
