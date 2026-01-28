//
//  RouteRegistry.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit

protocol ExploreRoutable {
    static var route: String { get }
    static func makeViewController() -> UIViewController
}
