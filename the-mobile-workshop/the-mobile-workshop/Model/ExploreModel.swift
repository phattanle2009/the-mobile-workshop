//
//  ExploreModel.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit

struct ExploreRoot: Decodable {
    let sections: [ExploreSection]
}

struct ExploreSection: Decodable {
    let id: String
    let title: String
    let description: String
    let items: [ExploreItem]
}

struct ExploreItem: Decodable {
    let id: String
    let title: String
    let description: String
    let route: String
    let icon: String?
//    var accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator
}
