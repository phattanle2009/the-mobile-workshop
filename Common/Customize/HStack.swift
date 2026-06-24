//
//  HStack.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit

final class HStack: UIStackView {

    init(distribution: Distribution = .fill,
         alignment: Alignment = .fill,
         spacing: CGFloat = 0.0,
         padding: UIEdgeInsets = .zero,
         views: [UIView]) {
        super.init(frame: .zero)
        axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        addArrangedSubviews(views)
        layoutMargins = padding
        isLayoutMarginsRelativeArrangement = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
