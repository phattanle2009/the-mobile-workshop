//
//  TaggedViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import UIKit
import SegementSlide
import SnapKit

class TaggedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SegementSlideContentScrollViewDelegate {
    private let tableView = UITableView(frame: .zero, style: .plain)

    var scrollView: UIScrollView {
        return tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .neutral0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TagCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        cell.textLabel?.text = "Tagged placeholder #\(indexPath.row + 1)"
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        cell.backgroundColor = .neutral0
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
