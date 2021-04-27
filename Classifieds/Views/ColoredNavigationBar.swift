//
//  ColoredNavo.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class ColoredNavigationBar: UINavigationBar {

	override init(frame: CGRect) {
		super.init(frame: frame)

		barTintColor = Color.Orange
		backgroundColor = Color.Orange
		tintColor = Color.White
		isTranslucent = false
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
