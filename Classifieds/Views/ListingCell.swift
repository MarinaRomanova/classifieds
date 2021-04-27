//
//  ListingCell.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class ListingCell: UITableViewCell {
	private let imageLoader = ImageLoader.shared

	var picture: UIImageView = {
		let img = UIImageView(image: UIImage(named: "AppIcon"))
		img.contentMode = .scaleAspectFill
		img.translatesAutoresizingMaskIntoConstraints = false
		img.layer.cornerRadius = 13
		img.clipsToBounds = true
		return img
	}()

	var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .whiteLarge)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()

	var titleLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = Font(.helveticaNeueMedium, size: .h20).instance
		label.textColor = Color.Dark
		label.numberOfLines = 0
		return label
	}()

	var categorieLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = Font(.helveticaNeueMedium, size: .h16).instance
		label.textColor = Color.GrayMidDark
		return label
	}()

	var priceLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = Font(.helveticaNeueMedium, size: .h20).instance
		label.textColor = Color.Dark
		return label
	}()

	let containerView:UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = .clear

		layer.shadowOpacity = 0.23
		layer.shadowRadius = 4
		layer.shadowOffset = CGSize(width: 0, height: 0)
		layer.shadowColor = Color.Black.cgColor

		initialize()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initialize() {
		selectionStyle = .none
		backgroundColor = Color.White

		accessibilityLabel = "listingCell"

		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 8
		contentView.layer.masksToBounds = true

		contentView.addSubview(containerView)
		contentView.addSubview(picture)
		containerView.addSubview(titleLabel)
		containerView.addSubview(priceLabel)
		containerView.addSubview(categorieLabel)

		NSLayoutConstraint.activate([
			picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10),
			picture.widthAnchor.constraint(equalToConstant:100),
			picture.heightAnchor.constraint(equalToConstant:100),

			containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			containerView.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant:10),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-20),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

			priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

			categorieLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
			categorieLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			categorieLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
		])
	}

	func configure(listing: Listing) {
		titleLabel.text = listing.title
		priceLabel.text = "\(listing.price) €"
		categorieLabel.text = listing.category.name

		if let path = listing.image?.small {
			imageLoader.loadImage(from: path) { [weak self] urlStr, data in
				guard path == urlStr else {
					return //cell reused
				}
				self?.picture.image = UIImage(data: data)
			}
		}
	}
}

extension UITableViewCell {
	static var identifier: String {
		return String(describing: self)
	}
}
