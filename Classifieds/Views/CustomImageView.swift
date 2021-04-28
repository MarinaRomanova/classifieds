//
//  CustomImageView.swift
//  Classifieds
//
//  Created by Marina Romanova on 28/04/2021.
//

import UIKit

class CustomImageView: UIImageView {

	init() {
		super.init(frame: .zero)

		translatesAutoresizingMaskIntoConstraints = false
		self.image = image != nil ? image :UIImage(named: "AppIcon")
		contentMode = .scaleAspectFill
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 13
		clipsToBounds = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
