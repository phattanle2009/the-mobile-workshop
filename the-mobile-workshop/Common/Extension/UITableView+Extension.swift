//
//  UITableView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit

extension UITableView {
    convenience init(
        tableStyle: UITableView.Style = .plain,
        backgroundColor: UIColor = .clear,
        separator: UITableViewCell.SeparatorStyle = .none
    ) {
        self.init(frame: .zero, style: tableStyle)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.separatorStyle = separator
        self.estimatedRowHeight = 44
        self.rowHeight = UITableView.automaticDimension
        self.keyboardDismissMode = .onDrag
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
}
