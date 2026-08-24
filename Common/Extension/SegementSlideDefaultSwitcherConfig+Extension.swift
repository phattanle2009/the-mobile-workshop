//
//  SegementSlideDefaultSwitcherConfig+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import Foundation
import SegementSlide

extension SegementSlideDefaultSwitcherConfig {
    static func renewal(itemCount: Int, screenWidth: CGFloat) -> SegementSlideDefaultSwitcherConfig {
        SegementSlideDefaultSwitcherConfig(
            type: .tab,
            horizontalMargin: 0,
            horizontalSpace: 0,
            normalTitleFont: .systemFont(ofSize: 12.0, weight: .medium),
            selectedTitleFont: .systemFont(ofSize: 12.0, weight: .medium),
            normalTitleColor: .lightGray,
            selectedTitleColor: .black,
            indicatorWidth: screenWidth / CGFloat(itemCount),
            indicatorColor: .systemMint
        )
    }
}
