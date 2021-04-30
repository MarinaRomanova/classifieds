//
//  DemoManager.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 29/04/2021.
//

import Foundation
@testable import Classifieds

enum MockManager {
	static func getJson(from route: Route, bundle: Bundle) -> Any? {
		switch route.path {
		case Routes.categories.path:
			return LoaderMockData.getJson(bundle: bundle, from: "MockCategories")
		case Routes.listings.path:
			return LoaderMockData.getJson(bundle: bundle, from: "MockListings")
		default:
			return nil
		}
	}
}

enum LoaderMockData {
	static func getJson(bundle: Bundle, from filename: String) -> Any? {
		if let data = get(bundle: bundle, fileName: filename, ofType: "json")?.data(using: String.Encoding.utf8) {
			if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) {
				return json
			}
		}
		return nil
	}

	static func get(bundle: Bundle = Bundle.main, fileName: String, ofType: String) -> String? {
		if let filePath = bundle.path(forResource: fileName, ofType: ofType) {
			if let contentFile = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8) {
				return contentFile
			}
		}
		return nil
	}
}
