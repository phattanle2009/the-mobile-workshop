//
//  UIViewController+Extension.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 5/2/26.
//

import UIKit

extension UIViewController {
    func addChild(_ viewController: UIViewController, to containerView: UIView) {
        addChild(viewController)
        viewController.willMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        viewController.didMove(toParent: self)
    }
}
