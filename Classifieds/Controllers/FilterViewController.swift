//
//  FilterViewController.swift
//  Classifieds
//
//  Created by Marina Romanova on 28/04/2021.
//

import UIKit

class FilterViewController: UITableViewController {
	private(set) var filters: [Filter]
	weak var filterDeleagate: FilterDelegate?

	init(filters: [Filter]) {
		self.filters = filters
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		initialize()
    }

	private func initialize() {
		title = "categories.title".localized()
		navigationItem.accessibilityLabel = "categories.title"

		tableView.accessibilityIdentifier = "filtersTableView"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
		tableView.tintColor = Color.Orange

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "categories.nav.reset".localized(), style: .plain, target: self, action: #selector(resetFilters))
		navigationItem.rightBarButtonItem?.accessibilityIdentifier = "categories.nav.reset"

		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "categories.nav.ok".localized(), style: .plain, target: self, action: #selector(applyFilters))
		navigationItem.leftBarButtonItem?.accessibilityIdentifier = "categories.nav.ok"
	}

	@objc
	private func applyFilters() {
		dismiss(animated: true, completion: nil)
	}

	@objc
	private func resetFilters() {
		for i in 0..<filters.count {
			filters[i].isSelected = false
		}
		tableView.reloadData()
	}

	override func viewWillDisappear(_ animated: Bool) {
		filterDeleagate?.applyFilters(filters)
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		resetFilters()
		let filter = filters[indexPath.row]
		filters[indexPath.row].isSelected = !filter.isSelected
		if let cell = tableView.cellForRow(at: indexPath) {
			toggleSelection(for: cell, selected: !filter.isSelected)
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		filters.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
		let filter = filters[indexPath.row]
		cell.textLabel?.text = filter.categoryName
		toggleSelection(for: cell, selected: filter.isSelected)
		cell.selectionStyle = .none
		return cell
	}

	private func toggleSelection(for cell: UITableViewCell, selected: Bool) {
		cell.accessoryType = selected ? .checkmark : .none
	}
}
