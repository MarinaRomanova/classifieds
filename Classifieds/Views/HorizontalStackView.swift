//
//  HorizontalStackView.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class HorizontalStackView: UIStackView {

	init(spacing: CGFloat = 10) {
		super.init(frame: .zero)

		axis = .horizontal
		alignment = .fill
		self.spacing = spacing
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
