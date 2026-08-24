//
//  MyProfileSlideViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import Foundation
import UIKit
import SnapKit
import SegementSlide

class MyProfileSlideViewController: IconSegementSlideDefaultViewController {

    var preferIndex: Int = 0

    override var switcherConfig: SegementSlideDefaultSwitcherConfig {
        return mySwitcherConfig
    }

    override var bouncesType: BouncesType {
        return .child
    }

    override var iconsInSwitcher: [UIImage] {
        profileTabItems.compactMap { $0.icon }
    }

    override var selectedIconsInSwitcher: [UIImage] {
        profileTabItems.compactMap { $0.selectedIcon }
    }

    private lazy var mySwitcherConfig = SegementSlideDefaultSwitcherConfig.renewal(itemCount: profileTabItems.count, screenWidth: view.bounds.width)

    private lazy var profileView = MyProfileView()

    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.color = .black
        loadingView.hidesWhenStopped = true
        return loadingView
    }()

    /// 投稿,コメントなどのセグメントの下線
    private lazy var slideSwitcherBottomlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private var profileTabItems = [SegementSlideTabItem]()
    private var postTableVC: PostsViewController?
    private var reelTableVC: ReelsViewController?
    private var tagTableVC: TaggedViewController?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .neutral0
        configureViews()
        bind()
    }

    override func segementSlideHeaderView() -> UIView? {
        return profileView
    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return profileTabItems[index].viewController
    }

    private func configureViews() {
        edgesForExtendedLayout = .bottom
        view.addSubview(slideSwitcherBottomlineView)
        view.addSubview(loadingView)

        slideSwitcherBottomlineView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(segementSlideSwitcherView().snp.bottom)
        }

        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30.0)
        }
    }

    private func bind() {
        scrollView.isHidden = false
        slideSwitcherBottomlineView.isHidden = false
        setupSlideContentViewControllers()
    }

    private func setupSlideContentViewControllers() {
        let postVC = PostsViewController()
        profileTabItems.append(
            SegementSlideTabItem(
                icon: UIImage(systemName: "square.grid.3x3"),
                selectedIcon: UIImage(systemName: "square.grid.3x3.fill"),
                viewController: postVC
            )
        )

        let reelVC = ReelsViewController()
        profileTabItems.append(
            SegementSlideTabItem(
                icon: UIImage(systemName: "play.rectangle"),
                selectedIcon: UIImage(systemName: "play.rectangle.fill"),
                viewController: reelVC
            )
        )

        let tagVC = TaggedViewController()
        profileTabItems.append(
            SegementSlideTabItem(
                icon: UIImage(systemName: "person.crop.square"),
                selectedIcon: UIImage(systemName: "person.crop.square.fill"),
                viewController: tagVC
            )
        )

        defaultSelectedIndex = preferIndex
        reloadData()
    }
}
