//
//  CustomLabel.swift
//  Classifieds
//
//  Created by Marina Romanova on 28/04/2021.
//

import UIKit

class CustomLabel: UILabel {

	init(text: String? = nil, color: UIColor = Color.Dark, font: Font = Font(.helveticaNeueMedium, size: .h20)) {
		super.init(frame: .zero)

		translatesAutoresizingMaskIntoConstraints = false

		if let text: String = text {
			self.text = text //TODO localization
			accessibilityLabel = text
		}
		textColor = color
		numberOfLines = 0
		self.font = font.instance
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension UILabel {
	func setBadgeStyle() {
		layer.cornerRadius = 8.0
		layer.borderWidth = 2
		backgroundColor = Color.Orange
		layer.borderColor = Color.Orange.cgColor
		layer.masksToBounds = true
		sizeToFit()
		text = text?.uppercased()
		textColor = Color.White
		font = Font(.helveticaNeueBold, size: .h14).instance
		textAlignment = .center
	}
}
