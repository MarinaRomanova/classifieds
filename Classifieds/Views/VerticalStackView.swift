//
//  VerticalStackView.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class VerticalStackView: UIStackView {

	init(spacing: CGFloat = 10) {
		super.init(frame: .zero)

		axis = .vertical
		alignment = .fill
		self.spacing = spacing
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
