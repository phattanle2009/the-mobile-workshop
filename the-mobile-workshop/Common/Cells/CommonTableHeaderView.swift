//
//  CommonTableHeaderView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit
import SnapKit

class CommonTableHeaderView: UITableViewHeaderFooterView {

    private lazy var titleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 18.0), color: .neutral900)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
