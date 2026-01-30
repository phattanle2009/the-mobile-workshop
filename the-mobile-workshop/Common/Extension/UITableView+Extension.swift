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

    func register(withCellClass clz: Swift.AnyClass) {
        let className = String(describing: clz)
        self.register(clz, forCellReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: T.classForCoder())
        guard let cell = self.dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("cell of [\(className)] is not register as \(className)")
        }
        return cell
    }

    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(withViewClass clz: T.Type) {
        self.register(clz, forHeaderFooterViewReuseIdentifier: String(describing: clz))
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }
}
