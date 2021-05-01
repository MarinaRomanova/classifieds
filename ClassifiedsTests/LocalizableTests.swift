//
//  LocalizableTests.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 01/05/2021.
//

import XCTest

class LocalizableTests: XCTestCase {
	var testBundle: Bundle!
	override func setUpWithError() throws {
		testBundle = Bundle(for: type(of: self))
	}

    func testBase() throws {
		let path = testBundle.path(forResource: "Localizable", ofType: "strings", inDirectory: nil, forLocalization: "en")!
		let dict = NSDictionary(contentsOfFile: path)

		let allKeys: [String] = dict!.allKeys as! [String]
		let allValues: [String] = dict!.allValues as! [String]

		testDict(allKeys: allKeys, allValues: allValues)
    }

	func testFR() throws {
		let path = testBundle.path(forResource: "Localizable", ofType: "strings", inDirectory: nil, forLocalization: "fr")!
		let dict = NSDictionary(contentsOfFile: path)

		let allKeys: [String] = dict!.allKeys as! [String]
		let allValues: [String] = dict!.allValues as! [String]

		testDict(allKeys: allKeys, allValues: allValues)
	}

	private func testDict(allKeys: [String], allValues: [String]) {
		var allKeysCopy = allKeys
		XCTAssertEqual(allKeys.count, 6)
		XCTAssertEqual(allValues.count, 6)

		XCTAssertTrue(allKeysCopy.remove(object: "listings.title"))
		XCTAssertTrue(allKeysCopy.remove(object: "listings.nav.filter"))
		XCTAssertTrue(allKeysCopy.remove(object: "listings.urgent"))
		XCTAssertTrue(allKeysCopy.remove(object: "categories.title"))
		XCTAssertTrue(allKeysCopy.remove(object: "categories.nav.ok"))
		XCTAssertTrue(allKeysCopy.remove(object: "categories.nav.reset"))

		XCTAssertEqual(allKeysCopy.count, 0)
	}
}

extension Array where Element: Equatable {
	mutating func remove(object: Element) -> Bool {
		if let index = firstIndex(where: { $0 == object }) {
			remove(at: index)
			return true
		}
		return false
	}
}
