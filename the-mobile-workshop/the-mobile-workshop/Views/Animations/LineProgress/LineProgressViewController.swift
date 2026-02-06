//
//  LineProgressViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 6/2/26.
//


import UIKit
import SnapKit

final class LineProgressViewController: BaseViewController, ExploreRoutable {

    static let route = "LineProgressViewController"

    static func makeViewController() -> UIViewController {
        LineProgressViewController()
    }

    private lazy var lineProgressView = LineProgressView(lineBackgroundColor: UIColor.neutral0.withAlphaComponent(0.5), gradientColors: [.systemPurple, .systemCyan])

    private lazy var hasAnimationLabel = UILabel(text: "Enable animation")

    private lazy var hasAnimation: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        return switchControl
    }()

    private lazy var enableAnimationStack = HStack(alignment: .center, spacing: 16.0, views: [hasAnimationLabel, hasAnimation])

    private lazy var timeIntervalTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.placeholder = "Animation duration in seconds (e.g., 0.5)"
        textField.keyboardLayoutGuide.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        return textField
    }()

    private lazy var inputValueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.placeholder = "Progress value range: 0.0 - 1.0"
        textField.keyboardLayoutGuide.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        return textField
    }()

    private lazy var setProgressButton: AppButton = {
        let button = AppButton(title: "Set Progress") { [weak self] in
            self?.didTapSetProgressButton()
        }
        return button
    }()

    private lazy var resetProgressButton: AppButton = {
        let button = AppButton(title: "Reset", style: .secondary) { [weak self] in
            self?.didTapResetProgressButton()
        }
        return button
    }()

    private lazy var buttonsStack = HStack(distribution: .fillEqually, spacing: 16.0, views: [setProgressButton, resetProgressButton])

    private lazy var contentStackView: UIStackView = {
        let vStack = VStack(spacing: 16.0, padding: .init(all: 16.0),
                            views: [lineProgressView, enableAnimationStack, timeIntervalTextField, inputValueTextField, buttonsStack])
        vStack.styling(bgColor: .systemGray4, cornerRadius: 16.0)
        return vStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .appBackground
        view.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
        }
        lineProgressView.snp.makeConstraints {
            $0.height.equalTo(14.0)
        }
        [enableAnimationStack, timeIntervalTextField, inputValueTextField, buttonsStack].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50.0)
            }
        }
    }

    private func didTapSetProgressButton() {
        let progressValue = CGFloat(Double(inputValueTextField.text ?? "0") ?? 0)
        let hasAnimation = hasAnimation.isOn
        let timeInterval: TimeInterval = Double(timeIntervalTextField.text ?? "0") ?? 0
        lineProgressView.setProgress(progressValue, animated: hasAnimation, duration: timeInterval)
    }

    private func didTapResetProgressButton() {
        lineProgressView.resetProgress()
    }
}
