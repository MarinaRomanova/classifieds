//
//  SplashViewController.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit
import Combine

class MainViewController: UIViewController {
	private let repo = ClassifiiedRepo()
		//= ClassifiiedRepo.shared
	//private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

		initView()

		repo.fetchListings()
//		cancellable = repo.$listings.sink { [weak self] listings in
//			if !listings.isEmpty {
//				self?.updateUI(listings)
//			}
//		}
    }

	deinit {
		//cancellable?.cancel()
	}

	private func updateUI(_ listings: [Listing]) {
		print(listings)
	}

	private func initView() {
		let logo: UIImageView = UIImageView(image: UIImage(named: "AppIcon"))
		let bottomImage: UIImageView = UIImageView(image: #imageLiteral(resourceName: "im_map"))

		let activityIndicator = UIActivityIndicatorView(style: .white)

		bottomImage.contentMode = .scaleAspectFill

		view.backgroundColor = Color.Dark
		view.addSubview(bottomImage)
		view.addSubview(logo)
		view.addSubview(activityIndicator)

		let margins = view.layoutMarginsGuide

		NSLayoutConstraint.activate([

			logo.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
			logo.centerXAnchor.constraint(equalTo: margins.centerXAnchor),

			activityIndicator.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
			activityIndicator.topAnchor.constraint(equalTo: logo.bottomAnchor),

			bottomImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
			bottomImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
			bottomImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
		])
	}
}
