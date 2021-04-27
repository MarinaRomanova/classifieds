//
//  ListingCell.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class ListingCell: UITableViewCell {
	var picture = UIImageView()
	var categorieLabel = UILabel()
	var titleLabel = UILabel()
	var priceLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		initialize()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initialize() {
		selectionStyle = .none
		backgroundColor = Color.White

		accessibilityLabel = "listingCell"


		let vStackView: VerticalStackView = VerticalStackView()
		let hStackView: HorizontalStackView = HorizontalStackView()

		hStackView.addSubview(picture)
		hStackView.addSubview(vStackView)

		contentView.addSubview(hStackView)
	}

	func configure(listing: Listing) {

	}
}
