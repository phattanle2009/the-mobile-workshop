//
//  UIStackView+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 28/1/26.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
}
