//
//  Appearance.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

enum Appearance {

	static func setNavigationBar() {
		if #available(iOS 13.0, *) {
			let appearance = UINavigationBarAppearance()

			appearance.backgroundColor = Color.Orange
			appearance.shadowColor = Color.Clear

			appearance.titleTextAttributes = [.foregroundColor: Color.White, .font: Font(.helveticaNeueMedium, size: .h18).instance]
			appearance.largeTitleTextAttributes = [.foregroundColor: Color.White, .font: Font(.helveticaNeueMedium, size: .h22).instance]

			appearance.buttonAppearance.normal.titleTextAttributes = [.font: Font(.helveticaNeueLight, size: .h14).instance]
			appearance.backButtonAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 0),
																		  .foregroundColor: UIColor.clear]
			appearance.doneButtonAppearance.normal.titleTextAttributes = [.font: Font(.helveticaNeueLight, size: .h14).instance]

			UINavigationBar.appearance().standardAppearance = appearance
			UINavigationBar.appearance().compactAppearance = appearance
			UINavigationBar.appearance().scrollEdgeAppearance = appearance

		} else {
			UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([
				NSAttributedString.Key.font: Font(.helveticaNeueLight, size: .h14).instance
			], for: .normal)

			UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([
				NSAttributedString.Key.font: Font(.helveticaNeueLight, size: .h14).instance
			], for: .highlighted)

			UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([
				NSAttributedString.Key.font: Font(.helveticaNeueLight, size: .h14).instance
			], for: .disabled)
		}
	}
}
