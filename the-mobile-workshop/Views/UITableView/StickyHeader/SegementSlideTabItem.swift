//
//  SegementSlideTabItem.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import Foundation
import UIKit
import SegementSlide

class SegementSlideTabItem {
    typealias SegmentSlideTabViewController = UIViewController & SegementSlideContentScrollViewDelegate

    var title: String = ""
    var icon: UIImage?
    var selectedIcon: UIImage?
    var viewController: SegmentSlideTabViewController

    init(title: String, viewController: SegmentSlideTabViewController) {
        self.title = title
        self.viewController = viewController
    }

    init(icon: UIImage?, selectedIcon: UIImage?, viewController: SegmentSlideTabViewController) {
        self.icon = icon
        self.selectedIcon = selectedIcon
        self.viewController = viewController
    }
}
