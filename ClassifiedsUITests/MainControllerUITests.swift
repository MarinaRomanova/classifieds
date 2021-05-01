//
//  MainControllerUITests.swift
//  ClassifiedsUITests
//
//  Created by Marina Romanova on 30/04/2021.
//

import XCTest

class MainControllerUITests: ClassifiedsUITests {

	func testNavigateToDetail() {
		start()

		app.tables["listingsTableView"].cells.allElementsBoundByIndex[4].tap()
		app.scrollViews.firstMatch.tap()
		app.navigationBars.buttons["listings.title"].tap()
		app.tables.firstMatch.tap()
	}

	func testNavigateToFilters() {
		start()
		app.navigationBars.firstMatch.buttons["listings.nav.filter"].tap()

		let tablesQuery = app.tables["filtersTableView"]
		tablesQuery.staticTexts["Multimédia"].tap()
		tablesQuery.staticTexts["Service"].tap()

		app.navigationBars.buttons["categories.nav.reset"].tap()
		app.navigationBars.buttons["OK"].tap()

		app.tables["listingsTableView"].firstMatch.tap()
	}
}
