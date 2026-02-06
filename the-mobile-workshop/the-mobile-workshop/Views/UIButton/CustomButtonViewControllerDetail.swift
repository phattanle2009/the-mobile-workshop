//
//  CustomButtonViewControllerDetail.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 5/2/26.
//

import UIKit
import SnapKit

final class CustomButtonViewControllerDetail: BaseViewController, ExploreRoutable, DataInjectable {

    static let route = "CustomButtonViewController.Detail"

    struct Input {
        let title: String
        let style: AppButton.Style
    }

    private var input: Input?

    static func makeViewController() -> UIViewController {
        CustomButtonViewControllerDetail()
    }

    func inject(data: Input) {
        self.input = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = input?.title
        let vStack = VStack(alignment: .center, spacing: 16, padding: .init(all: 16.0), views: [])
        getButtonList().forEach { button in
            vStack.addArrangedSubview(button)
        }
        vStack.styling(bgColor: .neutral200, cornerRadius: 16.0)
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).inset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
    }

    private func getButtonList() -> [AppButton] {
        switch input?.style {
        case .primary:
            return [
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .normal, tapState: .scale, size: .extraSmall, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .normal, tapState: .scale, size: .small, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .normal, tapState: .scale, size: .medium, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .normal, tapState: .scale, size: .large, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .disabled, tapState: .scale, size: .extraSmall, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .disabled, tapState: .scale, size: .small, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .disabled, tapState: .scale, size: .medium, onPressed: nil),
                AppButton(title: "Primary", icon: .icHome, style: .primary, state: .disabled, tapState: .scale, size: .large, onPressed: nil),
            ]
        case .secondary:
            return [
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .normal, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .normal, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .normal, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .normal, tapState: .alpha, size: .large, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .disabled, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .disabled, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .disabled, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Secondary", icon: .icHome, style: .secondary, state: .disabled, tapState: .alpha, size: .large, onPressed: nil),
            ]
        case .tertiary:
            return [
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .normal, tapState: .scaleAndAlpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .normal, tapState: .scaleAndAlpha, size: .small, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .normal, tapState: .scaleAndAlpha, size: .medium, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .normal, tapState: .scaleAndAlpha, size: .large, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .disabled, tapState: .scaleAndAlpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .disabled, tapState: .scaleAndAlpha, size: .small, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .disabled, tapState: .scaleAndAlpha, size: .medium, onPressed: nil),
                AppButton(title: "Tertiary", icon: .icHome, style: .tertiary, state: .disabled, tapState: .scaleAndAlpha, size: .large, onPressed: nil),
            ]
        case .text:
            return [
                AppButton(title: "Text", icon: .icHome, style: .text, state: .normal, tapState: .none, size: .extraSmall, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .normal, tapState: .none, size: .small, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .normal, tapState: .none, size: .medium, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .normal, tapState: .none, size: .large, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .disabled, tapState: .none, size: .extraSmall, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .disabled, tapState: .none, size: .small, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .disabled, tapState: .none, size: .medium, onPressed: nil),
                AppButton(title: "Text", icon: .icHome, style: .text, state: .disabled, tapState: .none, size: .large, onPressed: nil),
            ]
        case .destructive:
            return [
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .normal, tapState: .scale, size: .extraSmall, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .normal, tapState: .scale, size: .small, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .normal, tapState: .scale, size: .medium, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .normal, tapState: .scale, size: .large, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .disabled, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .disabled, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .disabled, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Destructive", icon: .icHome, style: .destructive, state: .disabled, tapState: .alpha, size: .large, onPressed: nil),
            ]
        case .icon:
            return [
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .normal, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .normal, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .normal, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .normal, tapState: .alpha, size: .large, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .disabled, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .disabled, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .disabled, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Icon", icon: .icRightArrow, style: .icon, state: .disabled, tapState: .alpha, size: .large, onPressed: nil),
            ]
        case .floating:
            return [
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .normal, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .normal, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .normal, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .normal, tapState: .alpha, size: .large, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .disabled, tapState: .alpha, size: .extraSmall, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .disabled, tapState: .alpha, size: .small, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .disabled, tapState: .alpha, size: .medium, onPressed: nil),
                AppButton(title: "Floating", icon: .icRightArrow, style: .floating, state: .disabled, tapState: .alpha, size: .large, onPressed: nil),
            ]
        case .none: return []
        }
    }
}
