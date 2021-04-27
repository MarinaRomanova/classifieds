//
//  SplashViewController.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class MainViewController: UIViewController {
	let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
	let tableView = UITableView()
	
	private let repo = ClassifiedRepo()
	private var listings = [Listing]()

	override func loadView() {
		super.loadView()
		//setupTableView()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		initView()

		repo.listingsDeleagate = self
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
		
		tableView.dataSource = self
	}

	private func updateUI(_ listings: [ListingsResponse]) {
		print(listings)
	}

	private func initView() {
		view.backgroundColor = Color.Dark
		view.addSubview(activityIndicator)

		setupTableView()

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
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
		//todo
	}

	func onError(error: Error) {
		//todo
	}

	func onListingsFetched(_ listings: [Listing]) {
		self.listings = listings
		tableView.reloadData()
	}
}
