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
	var createdAtLabel: UILabel = CustomLabel(color: Color.GrayMidDark, font: Font(.helveticaNeueMedium, size: .h16))
	var urgentLabel = PaddingLabel(text: "urgent")

	let contentView = UIView()

	var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.isScrollEnabled = true
		return scrollView //TODO problem scrolling
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
	}

	func initialize() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)

		contentView.addSubview(picture)
		contentView.addSubview(urgentLabel)
		contentView.addSubview(titleLabel)
		contentView.addSubview(priceLabel)
		contentView.addSubview(createdAtLabel)
		contentView.addSubview(descriptionLabel)

		NSLayoutConstraint.activate([
			scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

			contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

			picture.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			picture.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			picture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

			urgentLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 20),
			urgentLabel.topAnchor.constraint(equalTo: picture.topAnchor, constant: 10),

			titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			titleLabel.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: picture.trailingAnchor),

			priceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			priceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),

			createdAtLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			createdAtLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
			createdAtLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),

			descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			descriptionLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 40),
			descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
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
