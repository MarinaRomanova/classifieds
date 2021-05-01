//
//  Font.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

struct Font {
	enum FontName: String {
		// Helvetica Neue
		case helveticaNeueUltraLightItalic = "HelveticaNeue-UltraLightItalic"
		case helveticaNeueMedium = "HelveticaNeue-Medium"
		case helveticaNeueMediumItalic = "HelveticaNeue-MediumItalic"
		case helveticaNeueUltraLight = "HelveticaNeue-UltraLight"
		case helveticaNeueItalic = "HelveticaNeue-Italic"
		case helveticaNeueLight = "HelveticaNeue-Light"
		case helveticaNeueThinItalic = "HelveticaNeue-ThinItalic"
		case helveticaNeueLightItalic = "HelveticaNeue-LightItalic"
		case helveticaNeueBold = "HelveticaNeue-Bold"
		case helveticaNeueThin = "HelveticaNeue-Thin"
		case helveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
		case helveticaNeue = "HelveticaNeue"
		case helveticaNeueCondensedBold = "HelveticaNeue-CondensedBold"
		case helveticaNeueBoldItalic = "HelveticaNeue-BoldItalic"
	}
	enum FontSize: Double {
		case h64 = 64.0
		case h50 = 50.0
		case h40 = 40.0
		case h38 = 38.0
		case h35 = 35.0
		case h30 = 30.0
		case h28 = 28.0
		case h25 = 25.0
		case h24 = 24.0
		case h22 = 22.0
		case h21 = 21.0
		case h20 = 20.0
		case h18 = 18.0
		case h17 = 17.0
		case h16 = 16.0
		case h15 = 15.0
		case h14 = 14.0
		case h13 = 13.0
		case h12 = 12.0
		case h11 = 11.0
		case h10 = 10.0
		case h8 = 8.0
	}
	// 1
	var name: FontName
	var size: FontSize
	// 2
	init(_ name: FontName, size: FontSize) {
		self.name = name
		self.size = size
	}
}

extension Font {
	var instance: UIFont {
		guard let font = UIFont(name: name.rawValue, size: CGFloat(size.rawValue)) else {
			fatalError("\(name.rawValue) font is not installed, make sure it is added in Info.plist and logged with Utils.logAllAvailableFonts()")
		}
		return font
	}
}
