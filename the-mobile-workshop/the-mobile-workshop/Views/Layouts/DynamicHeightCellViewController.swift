//
//  DynamicHeightCellViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit

final class DynamicHeightCellViewController: UIViewController, ExploreRoutable {

    static let route = "Layout.DynamicHeightCell"

    static func makeViewController() -> UIViewController {
        DynamicHeightCellViewController()
    }
}
