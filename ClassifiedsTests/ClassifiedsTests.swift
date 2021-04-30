//
//  ClassifiedsTests.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 27/04/2021.
//

import XCTest
@testable import Classifieds

class ClassifiedsTests: XCTestCase {
	private var apiClient: MockClient!
	private var repo: ClassifiedRepo!
	private var controller: MainViewController!

    override func setUpWithError() throws {
		let testBundle = Bundle(for: type(of: self))
		apiClient = MockClient(bundle: testBundle)
		repo = ClassifiedRepo(apiClient: apiClient)

		controller = MainViewController(repo: repo)
    }

    override func tearDownWithError() throws {
    }

	func testContoller_loadedView() throws {
		XCTAssertNotNil(controller.repo)
		XCTAssertEqual(controller.listings.count, 0)
		XCTAssertEqual(controller.listings.count, 0)
		XCTAssertNotNil(controller.tableView)
	}
}
