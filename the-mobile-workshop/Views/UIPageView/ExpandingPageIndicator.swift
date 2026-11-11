//
//  ExpandingPageIndicator.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 11/11/26.
//

import UIKit
import SnapKit

class ExpandingPageIndicator: UIView {

    private let stackView = UIStackView()
    private var dotViews: [UIView] = []
    private var widthConstraints: [Constraint] = []

    var numberOfPages: Int = 0 {
        didSet { setupDots() }
    }

    var dotColor: UIColor = .systemGray4
    var activeDotColor: UIColor = .systemBlue

    private let dotSize: CGFloat = 8
    private let expandedWidth: CGFloat = 24

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 6 // indicator spacing
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews.removeAll()
        widthConstraints.removeAll()

        guard numberOfPages > 0 else { return }

        for index in 0..<numberOfPages {
            let dot = UIView()
            dot.backgroundColor = (index == 0) ? activeDotColor : dotColor
            dot.layer.cornerRadius = dotSize / 2
            dot.clipsToBounds = true

            stackView.addArrangedSubview(dot)
            dotViews.append(dot)

            let initialWidth = (index == 0) ? expandedWidth : dotSize

            dot.snp.makeConstraints {
                $0.height.equalTo(dotSize)
                let widthConstraint = $0.width.equalTo(initialWidth).constraint
                widthConstraints.append(widthConstraint)
            }
        }
    }

    // calculating stretching smoothy per swiping pixel
    func updateProgress(from scrollView: UIScrollView) {
        let width = scrollView.frame.width
        guard width > 0, numberOfPages > 1, !dotViews.isEmpty else { return }

        // minus 1 due to index 0 of scrollView is temp index
        let rawProgress = (scrollView.contentOffset.x / width) - 1.0

        // handling (0) to (n-1)
        let progress = rawProgress < 0 ? CGFloat(numberOfPages) + rawProgress : rawProgress

        let currentIndex = Int(floor(progress)) % numberOfPages
        let nextIndex = (currentIndex + 1) % numberOfPages
        let ratio = progress - floor(progress)

        for (index, dot) in dotViews.enumerated() {
            if index == currentIndex {
                let targetWidth = expandedWidth - (expandedWidth - dotSize) * ratio
                widthConstraints[index].update(offset: targetWidth)
                dot.backgroundColor = interpolateColor(from: activeDotColor, to: dotColor, with: ratio)
            } else if index == nextIndex {
                let targetWidth = dotSize + (expandedWidth - dotSize) * ratio
                widthConstraints[index].update(offset: targetWidth)
                dot.backgroundColor = interpolateColor(from: dotColor, to: activeDotColor, with: ratio)
            } else {
                widthConstraints[index].update(offset: dotSize)
                dot.backgroundColor = dotColor
            }
        }
    }

    // smoothy color transition between active and inactive state
    private func interpolateColor(from: UIColor, to: UIColor, with ratio: CGFloat) -> UIColor {
        let clampedRatio = max(0, min(1, ratio))
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        from.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        to.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(
            red: r1 + (r2 - r1) * clampedRatio,
            green: g1 + (g2 - g1) * clampedRatio,
            blue: b1 + (b2 - b1) * clampedRatio,
            alpha: a1 + (a2 - a1) * clampedRatio
        )
    }
}
