//
//  AppDelegate.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit
import CoreData

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
		let nav = UINavigationController()
		nav.viewControllers = [rootViewController]
		nav.navigationBar.tintColor = Color.White
		window?.rootViewController = nav
		window?.makeKeyAndVisible()
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Classifieds")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}
