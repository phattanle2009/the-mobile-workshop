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

    lazy var followersCountInfoView: CountInfoView = {
        let infoView = CountInfoView()
        infoView.count = 128
        infoView.descriptionText = "Follower"
        return infoView
    }()

    lazy var followsCountInfoView: CountInfoView = {
        let infoView = CountInfoView()
        infoView.count = 56
        infoView.descriptionText = "Following"
        return infoView
    }()

    lazy var postsCountInfoView: CountInfoView = {
        let infoView = CountInfoView()
        infoView.count = 24
        infoView.descriptionText = "Posts"
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

    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            usernameLabel,
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

    private lazy var profileInfoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
        makeActionButton(title: "Edit Profile")
    }()

    private lazy var shareProfileButton: UIButton = {
        makeActionButton(title: "Share")
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

        addSubview(avatarFrameView)
        addSubview(countInfoStackView)
        addSubview(profileInfoContainerView)
        profileInfoContainerView.addSubview(profileStackView)

        avatarFrameView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(Const.horizontalPadding)
            $0.size.equalTo(Const.avatarSize)
        }

        countInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(avatarFrameView.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().offset(-Const.horizontalPadding)
            $0.centerY.equalTo(avatarFrameView.snp.centerY).offset(-2)
            $0.height.equalTo(56)
        }

        profileInfoContainerView.snp.makeConstraints {
            $0.top.equalTo(avatarFrameView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-18)
        }

        profileStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: Const.horizontalPadding, bottom: 0, right: Const.horizontalPadding))
        }

        editProfileButton.snp.makeConstraints {
            $0.height.equalTo(Const.actionHeight)
        }
    }

    private func makeActionButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.textPrimary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        button.backgroundColor = .neutral100
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        return button
    }
}
