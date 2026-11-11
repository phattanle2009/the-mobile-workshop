//
//  BaseProfileView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import Foundation
import UIKit
import SnapKit

class BaseProfileView: UIView {

    private enum Const {
        static let horizontalPadding: CGFloat = 16
        static let avatarSize: CGFloat = 96
        static let actionHeight: CGFloat = 34
    }

    lazy var postsCountInfoView: CountInfoView = {
        let infoView = CountInfoView()
        infoView.count = 24
        infoView.descriptionText = "posts"
        return infoView
    }()

    lazy var followersCountInfoView: CountInfoView = {
        let infoView = CountInfoView()
        infoView.count = 1
        infoView.descriptionText = "follower"
        return infoView
    }()

    lazy var followsCountInfoView: CountInfoView = {
        let infoView = CountInfoView()
        infoView.count = 796231
        infoView.descriptionText = "following"
        return infoView
    }()

    lazy var countInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            postsCountInfoView,
            followersCountInfoView,
            followsCountInfoView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var nameAndCountInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            usernameLabel,
            countInfoStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var profileAndAvatarStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            avatarFrameView,
            nameAndCountInfoStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            profileAndAvatarStackView,
            screenNameLabel,
            selfIntroductionLabel,
            actionStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    lazy var avatarFrameView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .neutral100
        imageView.tintColor = .neutral400
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .center
        imageView.layer.cornerRadius = Const.avatarSize / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.neutral200.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Workshop User"
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    private lazy var workLabel: UILabel = {
        let label = UILabel()
        label.text = "Developer"
        label.textColor = .neutral900
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private lazy var screenNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@mobile_workshop"
        label.textColor = .neutral500
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    private lazy var selfIntroductionLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile header placeholder. Data, image and states will be connected later."
        label.textColor = .neutral700
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    private lazy var editProfileButton: UIButton = {
        makeActionButton(title: "Edit Profile", bgColor: .systemBlue, titleColor: .white)
    }()

    private lazy var shareProfileButton: UIButton = {
        makeActionButton(title: "Share", bgColor: .neutral100, titleColor: .textPrimary)
    }()

    private lazy var actionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            editProfileButton,
            shareProfileButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: Life cycle's
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        backgroundColor = .neutral0
        addSubview(profileStackView)

        avatarFrameView.snp.makeConstraints {
            $0.size.equalTo(Const.avatarSize)
        }

        profileStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: Const.horizontalPadding, bottom: 0, right: Const.horizontalPadding))
        }

        editProfileButton.snp.makeConstraints {
            $0.height.equalTo(Const.actionHeight)
        }
    }

    private func makeActionButton(title: String, bgColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        return button
    }
}
