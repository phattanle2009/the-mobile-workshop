//
//  UIView+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit

extension UIView {

    func styling(bgColor: UIColor = .clear,
                 cornerRadius: CGFloat = 0.0,
                 borderWidth: CGFloat = 0.0,
                 borderColor: UIColor = .clear) {
        backgroundColor = bgColor
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
