//
//  ExtendedDotViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 11/11/26.
//

import UIKit
import SnapKit

final class ExtendedDotViewController: BaseViewController, ExploreRoutable {

    static let route = "ExtendedDotViewController"

    static func makeViewController() -> UIViewController {
        ExtendedDotViewController()
    }

    private let pageColors: [UIColor] = [
        .systemBlue, .systemIndigo, .systemPurple, .systemPink, .systemRed,
        .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemCyan
    ]
    private let originalColors: [UIColor] = [
        .systemBlue, .systemIndigo, .systemPurple, .systemPink, .systemRed,
        .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemCyan
    ]
    private var wheelColors: [UIColor] = []
    private var autoScrollTimer: Timer?
    private var currentIndex: Int = 0
    private var isInitialLayoutDone = false

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .systemBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(PageCell.self, forCellWithReuseIdentifier: PageCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    private let pageIndicator: ExpandingPageIndicator = {
        let indicator = ExpandingPageIndicator()
        indicator.activeDotColor = .black
        indicator.dotColor = .systemGray4
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWheelData()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAutoScroll()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScroll()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isInitialLayoutDone, collectionView.bounds.width > 0 {
            isInitialLayoutDone = true
            let startOffset = CGFloat(1) * collectionView.bounds.width
            collectionView.setContentOffset(CGPoint(x: startOffset, y: 0), animated: false)
        }
    }

    private func setupWheelData() {
        guard let first = originalColors.first, let last = originalColors.last else { return }
        wheelColors = [last] + originalColors + [first]
        pageIndicator.numberOfPages = originalColors.count
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        view.addSubview(pageIndicator)

        pageIndicator.numberOfPages = pageColors.count

        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(300.0)
        }

        pageIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(20.0)
        }
    }

    // MARK: - Auto Scroll Logic
    private func startAutoScroll() {
        stopAutoScroll()
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }

    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }

    @objc private func scrollToNextPage() {
        let width = collectionView.bounds.width
        guard width > 0 else { return }

        // calculating index and next step
        let currentPage = Int(round(collectionView.contentOffset.x / width))
        let nextPage = currentPage + 1

        // avoid step out of limit
        if nextPage < wheelColors.count {
            let targetOffsetX = CGFloat(nextPage) * width
            collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        }
    }

    private func checkAndResetWheelPosition(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        guard width > 0 else { return }

        let currentPage = Int(round(scrollView.contentOffset.x / width))

        if currentPage == 0 {
            // from first temp index to real last index
            let targetOffset = CGFloat(originalColors.count) * width
            scrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: false)
        } else if currentPage == wheelColors.count - 1 {
            // from last temp index to real first index
            let targetOffset = CGFloat(1) * width
            scrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: false)
        }
    }
}

// MARK: - UICollectionView DataSource & DelegateFlowLayout
extension ExtendedDotViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wheelColors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.identifier, for: indexPath) as? PageCell else {
            return UICollectionViewCell()
        }
        let realIndex: Int
        if indexPath.item == 0 {
            realIndex = originalColors.count
        } else if indexPath.item == wheelColors.count - 1 {
            realIndex = 1
        } else {
            realIndex = indexPath.item
        }

        cell.configure(pageNumber: realIndex, color: wheelColors[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    // update pageIndicator while manual scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageIndicator.updateProgress(from: scrollView)

        let width = scrollView.frame.width
        guard width > 0 else { return }

        // immediately handle scroll logic in case manual scroll too fast from 0/n-1
        if scrollView.contentOffset.x <= 0 {
            let targetOffset = CGFloat(originalColors.count) * width
            scrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: false)
        } else if scrollView.contentOffset.x >= CGFloat(wheelColors.count - 1) * width {
            let targetOffset = CGFloat(1) * width
            scrollView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: false)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkAndResetWheelPosition(scrollView)
        startAutoScroll()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        checkAndResetWheelPosition(scrollView)
    }
}

// MARK: - Custom Cell
class PageCell: UICollectionViewCell {
    static let identifier = "PageCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(pageNumber: Int, color: UIColor) {
        contentView.backgroundColor = color
        titleLabel.text = "Page #\(pageNumber)"
    }
}
