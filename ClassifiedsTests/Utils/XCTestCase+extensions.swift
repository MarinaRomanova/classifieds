//
//  XCTestCase+extensions.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 30/04/2021.
//

import XCTest

extension XCTestCase {
	func wait(interval: TimeInterval = 0.2, completion: @escaping (() -> Void)) {
		let exp = expectation(description: "Fetching")
		DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
			completion()
			exp.fulfill()
		}
		waitForExpectations(timeout: interval + 0.2)
	}
}
