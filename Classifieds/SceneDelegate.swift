//
//  SceneDelegate.swift
//  Classifieds
//
//  Created by Marina Romanova on 02/05/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	@available(iOS 13.0, *)
	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}

