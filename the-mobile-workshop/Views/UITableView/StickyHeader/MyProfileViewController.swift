//
//  MyProfileViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit
import SnapKit

final class MyProfileViewController: BaseViewController, ExploreRoutable {

    // MARK: - Route
    static let route = "MyProfileViewController"
    static func makeViewController() -> UIViewController {
        MyProfileViewController()
    }

    // MARK: - Properties
    private let slideVC = MyProfileSlideViewController()
    private let containerView = UIView()
    lazy var navigationBar: UIView = {
        let navigationBar = UIView()
        navigationBar.backgroundColor = .neutral0
        navigationBar.addSubview(leftStackView)
        navigationBar.addSubview(titleLabel)
        navigationBar.addSubview(rightStackView)
        navigationBar.addSubview(separatorLine)

        leftStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.bottom.equalTo(navigationBar.snp.bottom).offset(-8)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(navigationBar.snp.bottom).offset(-22)
        }
        rightStackView.snp.makeConstraints {
            $0.trailing.equalTo(navigationBar.snp.trailing).offset(-8)
            $0.bottom.equalTo(navigationBar.snp.bottom).offset(-8)
        }
        separatorLine.isHidden = true
        separatorLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }

        return navigationBar
    }()

    lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .black
        return label
    }()

    lazy var separatorLine: UIView = {
        let line = UIView()
        line.snp.makeConstraints {
            $0.height.equalTo(1.0)
        }
        line.backgroundColor = .systemRed
        return line
    }()

    // Action
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .textPrimary
        button.snp.makeConstraints {
            $0.size.equalTo(28)
        }
        button.addTarget(self, action: #selector(tappedBackButton(_:)), for: .touchUpInside)
        return button
    }()

    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Profile"
        view.backgroundColor = .neutral0

        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.topMargin).offset(44.0)
        }

        containerView.backgroundColor = .neutral0
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }

        slideVC.preferIndex = 0
        addChild(slideVC, to: containerView)

        leftStackView.addArrangedSubview(backButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func tappedBackButton(_ sender: UIButton) {
        navController.popViewController(animated: true)
    }
}
