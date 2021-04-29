//
//  PaddingLabel.swift
//  Classifieds
//
//  Created by Marina Romanova on 29/04/2021.
//

import UIKit

class PaddingLabel: UILabel {

	@IBInspectable var verticalnset: CGFloat = 2.0
	@IBInspectable var horizontalInset: CGFloat = 4.0

	init(text: String? = nil) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		if let text: String = text {
			self.text = text
			accessibilityLabel = text
		}
		setBadgeStyle()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets(top: verticalnset, left: horizontalInset, bottom: verticalnset, right: horizontalInset)
		super.drawText(in: rect.inset(by: insets))
	}

	override var intrinsicContentSize: CGSize {
		get {
			var contentSize = super.intrinsicContentSize
			contentSize.height += verticalnset * 2
			contentSize.width += horizontalInset * 2
			return contentSize
		}
	}
}
