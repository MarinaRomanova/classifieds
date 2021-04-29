//
//  SplashViewController.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class MainViewController: UIViewController {
	weak var filterDeleagate: FilterDelegate?

	let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
	let tableView = UITableView()
	
	private let repo = ClassifiedRepo()
	private var listings = [Listing]()

	override func viewDidLoad() {
        super.viewDidLoad()

		initView()

		repo.listingsDeleagate = self
		repo.filterDeleagate = self

		repo.fetchListings()
    }

	func setupTableView() {
		view.addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ListingCell.self, forCellReuseIdentifier: ListingCell.identifier)

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		tableView.rowHeight = 120
		tableView.estimatedRowHeight = 120
		tableView.separatorStyle = .none
		tableView.accessibilityIdentifier = "tableView"
		
		tableView.dataSource = self
		tableView.delegate = self
	}

	private func initView() {
		title = "Annonces"
		view.addSubview(activityIndicator)

		setupTableView()

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

	@objc
	private func presentFilters() {
		let navigationController = UINavigationController()
		let filtersVC = FilterViewController(filters: repo.filters)
		filtersVC.filterDeleagate = self
		navigationController.viewControllers = [filtersVC]
		present(navigationController, animated: true, completion: nil)
	}
}

//MARK: = UITableViewDelegate
extension MainViewController : UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let listing = listings[indexPath.row]
		let nav = UINavigationController()
		nav.viewControllers = [DetailViewController(listing: listing)]
		navigationController?.pushViewController(DetailViewController(listing: listing), animated: true)
	}
}

//MARK: = UITableViewDataSource
extension MainViewController : UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		listings.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ListingCell.identifier, for: indexPath) as! ListingCell
		let listing = listings[indexPath.row]
		cell.configure(listing: listing)
		return cell
	}
}

extension MainViewController : ListingsDelegate {
	func onLoadingStarted() {
		activityIndicator.startAnimating()

	}

	func onError(error: Error) {
		activityIndicator.stopAnimating()
	}

	func onListingsFetched(_ listings: [Listing]) {
		activityIndicator.stopAnimating()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrer", style: .plain, target: self, action: #selector(presentFilters))
		self.listings = listings
		tableView.reloadData()
	}
}



extension MainViewController: FilterDelegate {
	func applyFilters(_ filters: [Filter]) {
		repo.filters = filters
	}
}
