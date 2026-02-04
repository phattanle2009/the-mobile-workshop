//
//  RouteResolver.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit

@MainActor
final class ExploreRouter {

    private static let registry: [String: () -> UIViewController] = [
        StickyHeaderViewController.route: StickyHeaderViewController.makeViewController,
        CircularProgressViewController.route: CircularProgressViewController.makeViewController,
        CustomButtonViewController.route: CustomButtonViewController.makeViewController
    ]

    static func resolve(route: String) -> UIViewController {
        guard let factory = registry[route] else {
            fatalError("Route not registered: \(route)")
        }
        return factory()
    }
}

