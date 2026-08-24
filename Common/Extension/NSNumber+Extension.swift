//
//  NSNumber+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import Foundation

extension NSNumber {
    // カンマ区切りの文字列に変換する
    var decimalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = Locale(identifier: "en_US")
        return numberFormatter.string(from: self) ?? ""
    }
}

extension Int {
    func shortDecimalString(threshold: Int) -> String {
        if self < threshold {
            return NSNumber(value: self).decimalString
        } else {
            if self < 1_000_000 {
                return "\(NSNumber(value: self / 1_000).decimalString).\(self / 100 % 10)K"
            } else if self < 1_000_000_000 {
                return "\(NSNumber(value: self / 1_000_000).decimalString).\(self / 100_000 % 10)M"
            } else {
                return "\(NSNumber(value: self / 1_000_000_000).decimalString).\(self / 100_000_000 % 10)B"
            }
        }
    }
}
