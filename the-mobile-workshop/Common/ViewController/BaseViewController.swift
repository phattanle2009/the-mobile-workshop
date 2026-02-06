//
//  BaseViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 4/2/26.
//

import UIKit

class BaseViewController: UIViewController {

    var navController: UINavigationController {
        return navigationController ?? UINavigationController(rootViewController: ExploreViewController())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
    }

    func pushToRoute(_ destination: String) {

    }
}
