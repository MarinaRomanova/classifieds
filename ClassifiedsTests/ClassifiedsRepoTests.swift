//
//  ClassifiedsRepoTests.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 30/04/2021.
//

import XCTest
@testable import Classifieds

class ClassifiedsRepoTests: XCTestCase {
	private var repo: ClassifiedRepo!

    override func setUpWithError() throws {
		let testBundle = Bundle(for: type(of: self))
		let apiClient = MockClient(bundle: testBundle)
		repo = ClassifiedRepo(apiClient: apiClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testData_fetched_and_mapped() throws {
		repo.fetchListings()
		wait {
			XCTAssertEqual(self.repo.listings.count, 5)
			XCTAssertEqual(self.repo.listings.first!.category.name, "Mode")


			XCTAssertEqual(self.repo.filters.count, 11)
			XCTAssertFalse(self.repo.filters.contains {$0.isSelected})
		}
	}
}
