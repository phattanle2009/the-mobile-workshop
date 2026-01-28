//
//  ExploreDataProvider.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import Foundation

final class ExploreDataProvider {

    static func load() -> ExploreRoot {
        guard
            let url = Bundle.main.url(forResource: "explores", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let root = try? JSONDecoder().decode(ExploreRoot.self, from: data)
        else {
            fatalError("Failed to load explores.json")
        }
        return root
    }
}
