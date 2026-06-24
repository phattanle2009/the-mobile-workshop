//
//  UINavigationController+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 5/2/26.
//

import UIKit

extension UINavigationController {

    func push<VC>(_ type: VC.Type, animated: Bool = true) where VC: UIViewController & ExploreRoutable {
        let vc = ExploreRouter.resolve(route: VC.route)
        pushViewController(vc, animated: animated)
    }

    func push<VC>(_ type: VC.Type, data: VC.DataType, animated: Bool = true) where VC: UIViewController & ExploreRoutable & DataInjectable {
        let vc: VC = ExploreRouter.resolve(
            route: VC.route,
            data: data
        )
        pushViewController(vc, animated: animated)
    }

    func push(to route: String) {
        let vc = ExploreRouter.resolve(route: route)
        pushViewController(vc, animated: true)
    }
}
