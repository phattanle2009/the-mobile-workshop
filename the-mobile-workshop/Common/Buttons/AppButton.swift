//
//  AppButton.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 30/1/26.
//

import UIKit
import SnapKit

final class AppButton: UIView {

    enum Style: CaseIterable {
        case primary
        case secondary
        case tertiary
        case text
        case destructive
        case icon
        case floating

        func getTitleColor() -> UIColor {
            switch self {
            case .primary: return .white
            case .secondary: return .neutral900
            default: return .label
            }
        }

        func getBGColor() -> UIColor {
            switch self {
            case .primary: return .buttonPrimary
            case .secondary: return .buttonSecondary
            default: return .systemYellow
            }
        }
    }

    enum State {
        case normal
        case disabled
        case loading
    }

    enum TapState {
        case none
        case highlighted
        case selected
        case animation
    }

    enum Size {
        case extraSmall
        case small
        case medium
        case large

        func getFont() -> UIFont {
            switch self {
            case .extraSmall: return .systemFont(ofSize: 10.0)
            case .small: return .systemFont(ofSize: 12.0)
            case .medium: return .systemFont(ofSize: 16.0)
            case .large: return .systemFont(ofSize: 20.0)
            }
        }

        func getButtonHeight() -> CGFloat {
            switch self {
            case .extraSmall: return 24.0
            case .small: return 32.0
            case .medium: return 40.0
            case .large: return 48.0
            }
        }

        func getIconSize() -> CGFloat {
            switch self {
            case .extraSmall: return 12.0
            case .small: return 20.0
            case .medium: return 24.0
            case .large: return 32.0
            }
        }

        func getVerticalPadding() -> CGFloat {
            switch self {
            case .extraSmall: return 8.0
            case .small: return 12.0
            case .medium: return 16.0
            case .large: return 24.0
            }
        }

        func getSpacing() -> CGFloat {
            switch self {
            case .extraSmall: return 2.0
            case .small: return 4.0
            case .medium: return 8.0
            case .large: return 12.0
            }
        }

        func getCornerRadius() -> CGFloat {
            switch self {
            case .extraSmall: return 12.0
            case .small: return 16.0
            case .medium: return 12.0
            case .large: return 12.0
            }
        }
    }

    var onPressed: (() -> Void)?

    private lazy var titleLabel: UILabel = {
        let label = UILabel(text: "", font: size.getFont(), color: style.getTitleColor())
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.size.equalTo(size.getIconSize())
        }
        return imageView
    }()

    private lazy var contentStackView = HStack(spacing: size.getSpacing(),
                                               padding: .init(horizontal: size.getVerticalPadding()),
                                               views: [iconImageView, titleLabel])

    private var style: Style = .primary
    private var state: State = .normal
    private var tapState: TapState = .highlighted
    private var size: Size = .medium
    private var title: String?
    private var icon: UIImage?

    init(
        title: String? = nil,
        icon: UIImage? = nil,
        style: Style = .primary,
        state: State = .normal,
        tapState: TapState = .highlighted,
        size: Size = .medium,
        onPressed: (() -> Void)? = nil
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.state = state
        self.onPressed = onPressed
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(size.getButtonHeight())
        }
        styling(bgColor: style.getBGColor(), cornerRadius: size.getCornerRadius())
        configure(withTitle: title, icon: icon)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc private func handleTap() {
        onPressed?()
    }

    // MARK: - Public API
    func configure(withTitle title: String?, icon: UIImage? = nil, state: State = .normal) {
        titleLabel.text = title
        if let icon = icon {
            iconImageView.image = icon
            iconImageView.isHidden = false
        } else {
            iconImageView.isHidden = true
        }
    }
}
