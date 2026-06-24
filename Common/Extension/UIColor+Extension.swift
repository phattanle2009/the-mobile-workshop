//
//  UIColor+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    static func hexStringToColor(hex: String) -> UIColor {
        return UIColor(hex: hex)
    }

    func hexValue() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return String(format: "%02X%02X%02X", Int(red * 255.0), Int(green * 255.0), Int(blue * 255.0))
    }
}
