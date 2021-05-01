//
//  String+Extensions.swift
//  Classifieds
//
//  Created by Marina Romanova on 01/05/2021.
//

import Foundation

extension String {

	func localized() -> String {
		return NSLocalizedString(self, value: "", comment: "")
	}

	func with(args: [CVarArg]) -> String {
		return String(format: self, arguments: args)
	}

	func with(arg: CVarArg) -> String {
		return String(format: self, arg)
	}
}
