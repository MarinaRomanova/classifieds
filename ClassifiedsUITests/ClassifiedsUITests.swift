//
//  ClassifiedsUITests.swift
//  ClassifiedsUITests
//
//  Created by Marina Romanova on 27/04/2021.
//

import XCTest

class ClassifiedsUITests: XCTestCase {
	var app = XCUIApplication()

	func start() {
		app.launch()
	}

	override func tearDown() {
		super.tearDown()

		app.terminate()
	}
}
