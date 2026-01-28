//
//  ViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 16/1/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView(tableStyle: .insetGrouped, separator: .singleLine)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private var exploreData: ExploreRoot!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        setupSearch()
        setupUI()
        loadData()
    }

    private func setupNavigation() {
        title = "Explores"
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupSearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadData() {
        exploreData = ExploreDataProvider.load()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return exploreData.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreData.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = exploreData.sections[indexPath.section].items[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = item.description
        if let icon = item.icon {
            content.image = UIImage(systemName: icon)
        }
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .systemGray5
        cell.selectionStyle = .gray
        content.imageProperties.tintColor = .white
        return cell
    }
}
