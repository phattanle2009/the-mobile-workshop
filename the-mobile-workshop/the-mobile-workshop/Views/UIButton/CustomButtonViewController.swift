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
        var views: [UIView] = []
        styles.forEach { style in
            let row = initButtonRow(style: style)
            views.append(row)
        }
        let vStack = VStack(spacing: 8.0, padding: .init(all: 16.0), views: views)
        vStack.styling(bgColor: .neutral200, cornerRadius: 16.0)
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.0)
        }
    }

    private func initButtonRow(style: AppButton.Style) -> HStack {
        let title = getButtonTitle(style: style)
        let label = UILabel(text: title.title, font: .systemFont(ofSize: 18.0), color: .neutral900)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        let button = AppButton(title: title.buttonTitle, style: style, state: .normal, tapState: .highlighted, size: .medium) {
            print("Taped on \(title.title)")
        }
        if style == .floating || style == .icon {
            button.snp.makeConstraints {
                $0.size.equalTo(40.0)
            }
            button.configure(withTitle: nil, icon: .add)
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
        case .primary: return ("Primary Button", "Primary")
        case .secondary: return ("Secondary Button", "Secondary")
        case .tertiary: return ("Tertiary Button", "Tertiary")
        case .text: return ("Text Button", "Text")
        case .destructive: return ("Destructive Button", "Destructive")
        case .icon: return ("Icon Button", "Icon")
        case .floating: return ("Floating Button", "Floating")
        }
    }
}
