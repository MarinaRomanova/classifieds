//
//  ClassifiedsTests.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 27/04/2021.
//

import XCTest
@testable import Classifieds

class MainVCTests: XCTestCase {
	private var repo: ClassifiedRepo!
	private var controller: MainViewController!

    override func setUpWithError() throws {
		let testBundle = Bundle(for: type(of: self))
		let apiClient = MockClient(bundle: testBundle)
		repo = ClassifiedRepo(apiClient: apiClient)

		controller = MainViewController(repo: repo)
    }

    override func tearDownWithError() throws {
    }

	func testContoller_initialized() throws {
		XCTAssertNotNil(controller.repo)
		XCTAssertEqual(controller.listings.count, 0)
		XCTAssertEqual(controller.listings.count, 0)
		XCTAssertNotNil(controller.tableView)
		XCTAssertNotNil(controller.activityIndicator)

		XCTAssertNil(controller.repo.filterDeleagate)
		XCTAssertNil(controller.repo.listingsDelegate)
		XCTAssertNil(controller.tableView.delegate)
		XCTAssertNil(controller.tableView.dataSource)
	}

	func testContoller_didLoad() throws {
		let view = controller.view!
		XCTAssertNotNil(controller.repo.filterDeleagate)
		XCTAssertNotNil(controller.repo.listingsDelegate)
		XCTAssertNotNil(controller.tableView.delegate)
		XCTAssertNotNil(controller.tableView.dataSource)

		XCTAssertTrue(((view.subviews.contains(controller.tableView))))
	}

	func testContoller_didUpdatedWithData() throws {
		_ = controller.view
		controller.repo.fetchListings()
		wait {
			XCTAssertEqual(self.controller.tableView.numberOfRows(inSection: 0), 5)
		}
	}

	func testController_filtersApplied() throws {
		_ = controller.view
		controller.repo.fetchListings()
		wait {
			self.controller.repo.filters = [Filter(categoryName: "Mode", isSelected: true)]
			XCTAssertEqual(self.controller.tableView.numberOfRows(inSection: 0), 1)
		}
	}
}
