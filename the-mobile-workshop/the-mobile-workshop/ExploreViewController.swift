//
//  ViewController.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 16/1/26.
//

import UIKit
import SnapKit

class ExploreViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView(tableStyle: .insetGrouped, separator: .none)
        table.register(withCellClass: CommontTableViewCell.self)
        table.registerHeaderFooterView(withViewClass: CommonTableHeaderView.self)
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
        view.backgroundColor = .appBackground

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBackground
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.neutral900
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.neutral900
        ]
        appearance.backgroundColor = .clear

        let navBar = navController.navigationBar
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.compactScrollEdgeAppearance = appearance
        navBar.prefersLargeTitles = true
        navBar.isTranslucent = true
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

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return exploreData.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreData.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = exploreData.sections[indexPath.section].items[indexPath.row]
        let lastIndex = exploreData.sections[indexPath.section].items.count - 1
        let cell = tableView.dequeueReusableCell(type: CommontTableViewCell.self, for: indexPath)
        cell.configure(withTitle: item.title, subtitle: item.description, showBottomLine: indexPath.row != lastIndex)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(type: CommonTableHeaderView.self)
        header?.setTitle(exploreData.sections[section].title)
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let route = exploreData.sections[indexPath.section].items[indexPath.row].route
        navController.push(to: route)
    }
}
