//
//  Color.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

enum Color {

	static let Black: UIColor = UIColor.black
	static let White: UIColor = UIColor.white
	static let Clear: UIColor = UIColor.clear

	/// #F2F2F2
	static let Background: UIColor = UInt(0xF2F2F2).convertToUIColor()
	/// #FAFAFA
	static let TabBar: UIColor = UInt(0xFAFAFA).convertToUIColor()
	/// #FF8C00
	static let Orange: UIColor = UInt(0xFF8C00).convertToUIColor()
	/// #F9F9F9
	static let OffWhite: UIColor = UInt(0xF9F9F9).convertToUIColor()

	/// #676A6C
	static let GrayDark: UIColor = UInt(0x676A6C).convertToUIColor()
	/// #A4AAB3
	static let GrayMidDark: UIColor = UInt(0xA4AAB3).convertToUIColor()
	/// #d8d8d8
	static let Gray: UIColor = UInt(0xd8d8d8).convertToUIColor()
	/// #E9E9EA
	static let GrayMidLight: UIColor = UInt(0xE9E9EA).convertToUIColor()
	/// #F4F5F5
	static let GrayLight: UIColor = UInt(0xF4F5F5).convertToUIColor()
	/// #979797
	static let Gray1: UIColor = UInt(0x979797).convertToUIColor()
	/// #818B91
	static let Gray2: UIColor = UInt(0x818B91).convertToUIColor()


	/// #21222E
	static let Dark: UIColor = UInt(0x21222E).convertToUIColor()
	///	#303144
	static let DarkBackground: UIColor = UInt(0x303144).convertToUIColor()
	/// #47A4B4
	static let BlueLight: UIColor = UInt(0x47A4B4).convertToUIColor()
}

extension UInt {

	func convertToUIColor(alpha: Float = 1.0) -> UIColor {
		return UIColor(
			red: CGFloat((self & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((self & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(self & 0x0000FF) / 255.0,
			alpha: CGFloat(alpha)
		)
	}
}

