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
        CustomButtonViewController.route: CustomButtonViewController.makeViewController,
        CustomButtonViewControllerDetail.route: CustomButtonViewControllerDetail.makeViewController,
        LineProgressViewController.route: LineProgressViewController.makeViewController,
    ]

    static func resolve<VC: UIViewController & DataInjectable>(route: String, data: VC.DataType) -> VC {
        guard let factory = registry[route] else {
            fatalError("Route not registered: \(route)")
        }
        guard let vc = factory() as? VC else {
            fatalError("Route \(route) does not match expected VC type \(VC.self)")
        }
        vc.inject(data: data)
        return vc
    }

    static func resolve(route: String) -> UIViewController {
        guard let factory = registry[route] else {
            fatalError("Route not registered: \(route)")
        }
        return factory()
    }
}
