//
//  UILabel+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit

extension UILabel {

    convenience init(text: String = "",
                     font: UIFont = .systemFont(ofSize: 18.0),
                     color: UIColor = .neutral0,
                     numberOfLine: Int = 0) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLine
    }

    func setText(_ text: String, withColor color: UIColor) {
        self.text = text
        self.textColor = color
    }
}
