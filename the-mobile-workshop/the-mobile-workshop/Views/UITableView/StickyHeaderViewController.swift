//
//  StickyHeaderViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 19/1/26.
//

import UIKit
import SnapKit

final class StickyHeaderViewController: BaseViewController, ExploreRoutable {

    static let route = "StickyHeaderViewController"

    static func makeViewController() -> UIViewController {
        StickyHeaderViewController()
    }

    private var containerScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerScrollView)
        containerScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

class PostsViewController: UIViewController, UICollectionViewDataSource {
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width/3) - 2, height: (view.frame.width/3) - 2)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PostCell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .white

        // Quan trọng: Để cuộn mượt bên trong container
        collectionView.isScrollEnabled = true
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath)
        cell.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        return cell
    }
}

class ReelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView(tableStyle: .insetGrouped, backgroundColor: .neutral0, separator: .singleLine)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReelCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white

        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReelCell", for: indexPath)
        cell.textLabel?.text = "🎥 Reel Video #\(indexPath.row + 1)"
        cell.backgroundColor = .systemRed.withAlphaComponent(0.6)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

class TaggedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView(tableStyle: .plain, backgroundColor: .neutral0, separator: .singleLine)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TagCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        cell.textLabel?.text = "🎥 Tag Video #\(indexPath.row + 1)"
        cell.backgroundColor = .systemYellow.withAlphaComponent(0.6)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
