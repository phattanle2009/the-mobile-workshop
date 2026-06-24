//
//  UIEdgeInsets+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit

extension UIEdgeInsets {

    init(all offset: CGFloat) {
        self.init(top: offset, left: offset, bottom: offset, right: offset)
    }

    init(horizontal: CGFloat = 0.0, vertical: CGFloat = 0.0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.init(top: top, left: leading, bottom: bottom, right: trailing)
    }
}
