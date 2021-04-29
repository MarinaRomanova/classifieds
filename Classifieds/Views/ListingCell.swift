//
//  ListingCell.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class ListingCell: UITableViewCell {
	private let imageLoader = ImageLoader.shared

	var picture: UIImageView = CustomImageView()

	var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .whiteLarge)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()

	var titleLabel : UILabel = CustomLabel()
	var priceLabel : UILabel = CustomLabel()
	var categorieLabel: UILabel = CustomLabel(color: Color.GrayMidDark, font: Font(.helveticaNeueMedium, size: .h16))
	var createdAtLabel: UILabel = CustomLabel(color: Color.GrayMidDark, font: Font(.helveticaNeueLight, size: .h14))
	let urgentLabel = PaddingLabel(text: "urgent")

	let containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		accessibilityLabel = reuseIdentifier != nil ? reuseIdentifier : "listingCell"
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

		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 8
		contentView.layer.masksToBounds = true

		contentView.addSubview(containerView)
		contentView.addSubview(picture)

		containerView.addSubview(titleLabel)
		containerView.addSubview(priceLabel)
		containerView.addSubview(categorieLabel)
		containerView.addSubview(createdAtLabel)

		NSLayoutConstraint.activate([
			picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:20),
			picture.widthAnchor.constraint(equalToConstant:105),
			picture.heightAnchor.constraint(equalToConstant:140),

			containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			containerView.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant:10),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-20),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

			priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
			priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

			categorieLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
			categorieLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			categorieLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

			createdAtLabel.topAnchor.constraint(equalTo: categorieLabel.bottomAnchor, constant: 10),
			createdAtLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			createdAtLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
		])

		urgentLabel.font = Font(.helveticaNeueMedium, size: .h12).instance
		contentView.addSubview(urgentLabel)
		urgentLabel.leadingAnchor.constraint(equalTo: picture.leadingAnchor, constant: 5).isActive = true
		urgentLabel.topAnchor.constraint(equalTo: picture.topAnchor, constant: 5).isActive = true
	}

	func configure(listing: Listing) {
		titleLabel.text = listing.title
		titleLabel.numberOfLines = 2

		priceLabel.text = listing.price
		categorieLabel.text = listing.category.name
		createdAtLabel.text = listing.creationDate.getFormattedDate()

		if let path = listing.image?.small {
			imageLoader.loadImage(from: path) { [weak self] urlStr, data in
				guard path == urlStr else {
					return //cell reused
				}
				self?.picture.image = UIImage(data: data)
			}
		}

		urgentLabel.isHidden = !listing.isUrgent
	}
}

extension UITableViewCell {
	static var identifier: String {
		return String(describing: self)
	}
}
