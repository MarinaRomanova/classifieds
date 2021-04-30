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
		app.navigationBars.firstMatch.buttons["Annonces"].tap()
		app.tables.firstMatch.tap()
	}

	func testNavigateToFilters() {
		start()
		app.navigationBars.firstMatch.buttons["Filtrer"].tap()

		let tablesQuery = app.tables["filtersTableView"]
		tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Multimédia"]/*[[".cells.staticTexts[\"Multimédia\"]",".staticTexts[\"Multimédia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Service"]/*[[".cells.staticTexts[\"Service\"]",".staticTexts[\"Service\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

		let navBar = app.navigationBars["Categories"]
		navBar.buttons["Reset"].tap()
		navBar.buttons["OK"].tap()

		app.tables["listingsTableView"].firstMatch.tap()
	}
}
