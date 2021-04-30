//
//  FilterVCTests.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 30/04/2021.
//

import XCTest
@testable import Classifieds

class FilterVCTests: XCTestCase {
	private var controller: FilterViewController!

    override func setUpWithError() throws {
		let testBundle = Bundle(for: type(of: self))
		let categoriesJson = LoaderMockData.getJson(bundle: testBundle, from: "MockCategories")!
		let categories: [Classifieds.Category] = try! Utils.decode(decoder: JSONDecoder(), value: categoriesJson)
		let filters: [Filter] = categories.map {$0.mapToFilter()}

		controller = FilterViewController(filters: filters)
	}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testContoller_initialized() throws {
		XCTAssertNotNil(controller.filters)
		XCTAssertNil(controller.filterDeleagate)
	}

	func testContoller_didLoad() throws {
		let view = controller.view!
		XCTAssertEqual(controller.title, "Categories")
		XCTAssertNotNil(controller.tableView)
		XCTAssertNotNil(controller.tableView.delegate)
		XCTAssertNotNil(controller.tableView.dataSource)
		XCTAssertNotNil(controller.navigationItem.leftBarButtonItem)
		XCTAssertNotNil(controller.navigationItem.rightBarButtonItem)

		XCTAssertTrue(((view.contains(controller.tableView))))
	}
}
