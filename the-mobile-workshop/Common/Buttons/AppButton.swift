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
            case .primary, .destructive: return .neutral0
            case .secondary: return .buttonSecondaryText
            case .tertiary, .text: return .buttonTertiaryText
            default: return .clear
            }
        }

        func getBGColor() -> UIColor {
            switch self {
            case .primary: return .buttonPrimaryBG
            case .secondary: return .buttonSecondaryBG
            case .tertiary, .text: return .clear
            case .destructive: return .buttonDestructive
            default: return .systemYellow
            }
        }

        func getBorderColor() -> UIColor {
            switch self {
            case .tertiary: return .buttonTertiaryBorder
            default: return .clear
            }
        }

        func getBorderWidth() -> CGFloat {
            switch self {
            case .tertiary: return 1.0
            default: return 0.0
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
            case .extraSmall: return .systemFont(ofSize: 10.0, weight: .light)
            case .small: return .systemFont(ofSize: 12.0, weight: .medium)
            case .medium: return .systemFont(ofSize: 16.0, weight: .bold)
            case .large: return .systemFont(ofSize: 20.0, weight: .semibold)
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

        func getHorizontalPadding() -> CGFloat {
            switch self {
            case .extraSmall: return 8.0
            case .small: return 12.0
            case .medium: return 16.0
            case .large: return 24.0
            }
        }

        func getPaddingForIconAndFloating() -> CGFloat {
            switch self {
            case .extraSmall: return 2.0
            case .small: return 4.0
            case .medium: return 8.0
            case .large: return 12.0
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

    struct TapAnimationStep {
        let duration: TimeInterval
        let animations: () -> Void
    }

    struct TapAnimationSequence {
        let steps: [TapAnimationStep]
    }

    var onPressed: (() -> Void)?

    private lazy var titleLabel: UILabel = {
        let label = UILabel(text: "", font: size.getFont(), color: style.getTitleColor())
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.isHidden = style == .floating || style == .icon
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

    private lazy var contentStackView: HStack = {
        let padding: UIEdgeInsets = (style == .floating || style == .icon) ? .init(all: size.getPaddingForIconAndFloating()) : .init(horizontal: size.getHorizontalPadding())
        let hStack = HStack(spacing: size.getSpacing(),
                            padding: padding,
                            views: [iconImageView, titleLabel])
        return hStack
    }()

    private var title: String?
    private var icon: UIImage?
    private var style: Style = .primary
    private var state: State = .normal
    private var tapState: TapState = .highlighted
    private var size: Size = .medium

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
        self.tapState = tapState
        self.size = size
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
        styling(bgColor: style.getBGColor(),
                cornerRadius: size.getCornerRadius(),
                borderWidth: style.getBorderWidth(),
                borderColor: style.getBorderColor())
        configure(withTitle: title, icon: icon)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc private func handleTap() {
        guard state == .normal else { return }
        setTapState(.highlighted)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            self.setTapState(.animation)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            self.setTapState(.none)
            self.onPressed?()
        }
    }

    private func setTapState(_ newState: TapState, animated: Bool = true) {
        tapState = newState
        applyTapState(newState, animated: animated)
    }

    private func applyTapState(_ tapState: TapState, animated: Bool) {
        let animations = {
            switch tapState {
            case .highlighted:
                self.alpha = 0.85
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            case .animation:
                self.alpha = 0.9
                self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            default: return
            }
        }

        if animated {
            UIView.animate(
                withDuration: 0.12,
                delay: 0,
                options: [.curveEaseOut, .allowUserInteraction],
                animations: animations
            )
        } else {
            animations()
        }
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
