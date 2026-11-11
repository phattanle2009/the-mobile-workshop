//
//  UIViewController+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 5/2/26.
//

import UIKit
import SnapKit

extension UIViewController {
    func addChild(_ viewController: UIViewController, to containerView: UIView) {
        addChild(viewController)
        viewController.willMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
}
