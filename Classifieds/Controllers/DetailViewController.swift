//
//  DetailViewController.swift
//  Classifieds
//
//  Created by Marina Romanova on 28/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
	private let imageLoader = ImageLoader.shared
	private let listing: Listing

	var picture: UIImageView = CustomImageView()
	var titleLabel: UILabel = CustomLabel()
	var priceLabel: UILabel = CustomLabel()
	var descriptionLabel: UILabel = CustomLabel(font: Font(.helveticaNeueLight, size: .h16))
	var createdAtLabel: UILabel = CustomLabel(color: Color.GrayMidDark, font: Font(.helveticaNeueLight, size: .h16))
	var urgentLabel = PaddingLabel(text: "listings.urgent".localized())

	let contentView: UIStackView = {
		let content = UIStackView()
		content.translatesAutoresizingMaskIntoConstraints = false
		content.spacing = 20
		content.axis = .vertical
		return content
	}()

	var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.isScrollEnabled = true
		scrollView.showsVerticalScrollIndicator = false
		return scrollView
	}()

	init(listing: Listing) {
		self.listing = listing
		super.init(nibName: nil, bundle: nil)

		view.backgroundColor = Color.OffWhite
		title = listing.category.name
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		initialize()
		configure()
    }

	func configure() {
		titleLabel.text = listing.title
		priceLabel.text = listing.price
		descriptionLabel.text = listing.description
		createdAtLabel.text = listing.creationDate.getFormattedDate()

		if let path = listing.image?.thumb {
			imageLoader.loadImage(from: path) { [weak self] urlStr, data in
				guard path == urlStr else {
					return //wrong path
				}
				self?.picture.image = UIImage(data: data)
			}
		} else {
			self.picture.image = UIImage()
		}

		if listing.isUrgent {
			contentView.addSubview(urgentLabel)
			urgentLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 20).isActive = true
			urgentLabel.topAnchor.constraint(equalTo: picture.topAnchor, constant: 10).isActive = true
		}
	}

	func initialize() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)

		contentView.addArrangedSubview(picture)
		contentView.addArrangedSubview(titleLabel)
		contentView.addArrangedSubview(priceLabel)
		contentView.addArrangedSubview(createdAtLabel)
		contentView.addArrangedSubview(descriptionLabel)

		NSLayoutConstraint.activate([
			scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

			contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}
}

extension Date {
	func getFormattedDate(format: String = "d MMM yyyy HH:mm") -> String {
		let dateformat = DateFormatter()
		dateformat.dateFormat = format
		return dateformat.string(from: self)
	}
}
