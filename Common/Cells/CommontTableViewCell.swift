//
//  CommontTableViewCell.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 29/1/26.
//

import UIKit
import SnapKit

class CommontTableViewCell: UITableViewCell {

    private lazy var titleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16.0), color: .neutral900)

    private lazy var subtitleLabel = UILabel(text: "", font: .systemFont(ofSize: 14.0), color: .neutral500)

    private lazy var labelStackView = VStack(spacing: 4.0, views: [titleLabel, subtitleLabel])

    private lazy var rightIconView: UIImageView = {
        let imageView = UIImageView(image: .icChevronRight)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var containerStackView = HStack(alignment: .center, spacing: 8.0, padding: .init(all: 16.0), views: [labelStackView, rightIconView])

    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.styling(bgColor: .neutral100)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .cellBackground
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        rightIconView.snp.makeConstraints {
            $0.size.equalTo(16.0)
        }

        addSubview(bottomLine)
        bottomLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1.0)
        }

        let selectedView = UIView()
        selectedView.backgroundColor = .black
        selectedBackgroundView = selectedView
        selectionStyle = .default
    }

    func configure(withTitle: String, subtitle: String, showBottomLine: Bool = true) {
        titleLabel.text = withTitle
        subtitleLabel.text = subtitle
        bottomLine.isHidden = !showBottomLine
    }
}
