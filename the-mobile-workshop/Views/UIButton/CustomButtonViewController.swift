//
//  CustomButtonViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 3/2/26.
//

import UIKit
import SnapKit

final class CustomButtonViewController: BaseViewController, ExploreRoutable {

    static let route = "CustomButtonViewController"

    static func makeViewController() -> UIViewController {
        CustomButtonViewController()
    }

    private let styles = AppButton.Style.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        let centerTitle = UILabel(text: "Button list", font: .systemFont(ofSize: 24.0, weight: .bold), color: .neutral900, numberOfLine: 0)
        var views: [UIView] = [centerTitle]
        styles.forEach { style in
            let row = initButtonRow(style: style)
            views.append(row)
        }
        let vStack = VStack(spacing: 8.0, padding: .init(all: 16.0), views: views)
        vStack.styling(bgColor: .neutral200, cornerRadius: 16.0)
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).inset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
    }

    private func initButtonRow(style: AppButton.Style) -> HStack {
        let title = getButtonTitle(style: style)
        let label = UILabel(text: title.title, font: .systemFont(ofSize: 18.0), color: .neutral900)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        let button = AppButton(title: title.buttonTitle, style: style, state: .normal, tapState: .scaleAndAlpha, size: .medium) { [weak self] in
            self?.navController.push(CustomButtonViewControllerDetail.self, data: .init(title: title.title, style: style))
        }
        if style == .floating || style == .icon {
            button.snp.makeConstraints {
                $0.size.equalTo(50.0)
            }
            button.configure(withTitle: nil, icon: .icRightArrow)
        } else {
            button.snp.makeConstraints {
                $0.width.equalTo(130.0)
            }
        }
        let hStack = HStack(alignment: .center, spacing: 16, padding: .init(all: 12.0), views: [label, button])
        hStack.styling(bgColor: .neutral0, cornerRadius: 12.0)
        return hStack
    }

    private func getButtonTitle(style: AppButton.Style) -> (title: String, buttonTitle: String) {
        switch style {
        case .primary: return ("Primary Button", "Open")
        case .secondary: return ("Secondary Button", "Open")
        case .tertiary: return ("Tertiary Button", "Open")
        case .text: return ("Text Button", "Open")
        case .destructive: return ("Destructive Button", "Open")
        case .icon: return ("Icon Button", "Open")
        case .floating: return ("Floating Button", "Open")
        }
    }
}
