//
//  StickyHeaderViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit

final class StickyHeaderViewController: UIViewController, ExploreRoutable {

    static let route = "StickyHeaderViewController"

    static func makeViewController() -> UIViewController {
        StickyHeaderViewController()
    }
}
