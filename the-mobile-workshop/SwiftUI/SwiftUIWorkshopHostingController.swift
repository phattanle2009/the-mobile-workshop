//
//  SwiftUIWorkshopHostingController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 26/6/26.
//

import SwiftUI

final class SwiftUIWorkshopHostingController<Content: View>: UIHostingController<Content> {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
