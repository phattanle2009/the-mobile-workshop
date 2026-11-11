//
//  CountInfoView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import Foundation
import UIKit
import SnapKit

class CountInfoView: UIStackView {

    var count: Int = 0 {
        didSet {
            countLabel.text = max(count, 0).shortDecimalString(threshold: 10_000)
        }
    }

    var countTextColor: UIColor? = .black {
        didSet {
            countLabel.textColor = countTextColor
        }
    }

    var countFont = UIFont.systemFont(ofSize: 18.0, weight: .medium) {
        didSet {
            countLabel.font = countFont
        }
    }

    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }

    var descriptionTextColor: UIColor? = .lightGray {
        didSet {
            descriptionLabel.textColor = descriptionTextColor
        }
    }

    var descriptionFont = UIFont.systemFont(ofSize: 12.0, weight: .regular) {
        didSet {
            descriptionLabel.font = descriptionFont
        }
    }

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = countTextColor
        label.font = countFont
        label.text = count.shortDecimalString(threshold: 10_000)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = descriptionFont
        label.text = descriptionText
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit() {
        addArrangedSubview(countLabel)
        addArrangedSubview(descriptionLabel)
        axis = .vertical
        spacing = 4.0
        alignment = .leading
        distribution = .fill

        countLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }
    }
}
