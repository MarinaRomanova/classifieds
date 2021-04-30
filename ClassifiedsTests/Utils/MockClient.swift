//
//  DemoClient.swift
//  ClassifiedsTests
//
//  Created by Marina Romanova on 29/04/2021.
//

import Foundation
@testable import Classifieds

final class MockClient: Api {
	private var bundle: Bundle
	
	init(bundle: Bundle) {
		self.bundle = bundle
	}

	func fetch<T: Decodable>(_ route: Route, decoder: JSONDecoder,
								   completion: @escaping (CustomResult<[T]>) -> Void) {
		
		if let value = MockManager.getJson(from: route, bundle: bundle) {
			do {
				let object: [T] = try Utils.decode(decoder: decoder, value: value)
				completion(.success(object))
			} catch {
				completion(.failure(Errors.failToDecode))
			}
		} else {
			completion(.failure(Errors.failToDecode))
		}
	}
}

enum Utils {
	static func decode<T: Decodable>(decoder: JSONDecoder, value: Any) throws -> [T] {
		let json = try JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed)
		let object = try decoder.decode([T].self, from: json)

		return object
	}
}
