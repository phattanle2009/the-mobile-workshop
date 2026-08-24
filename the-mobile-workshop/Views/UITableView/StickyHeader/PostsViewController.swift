//
//  PostsViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/8/26.
//

import UIKit
import SegementSlide
import SnapKit

class PostsViewController: UIViewController, UICollectionViewDataSource, SegementSlideContentScrollViewDelegate {
    private var collectionView: UICollectionView!

    var scrollView: UIScrollView {
        return collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .neutral0

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PostCell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        let itemWidth = floor((view.bounds.width - 2) / 3)
        if layout.itemSize.width != itemWidth {
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.invalidateLayout()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? .neutral100 : .neutral200
        return cell
    }
}
