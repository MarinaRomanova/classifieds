//
//  AppDelegate.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		window = UIWindow(frame: UIScreen.main.bounds)

		setAppearance()
		set(rootViewController: MainViewController())
		return true
	}

	func setAppearance() {
		Appearance.setNavigationBar()
	}

	func set(rootViewController: UIViewController) {
		window?.subviews.forEach({ $0.removeFromSuperview() })
		window?.rootViewController = nil
		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()
	}
}

