//
//  ApiClient.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

enum CustomResult<Value> {
	case success(Value)
	case failure(Error?)
}

final class ApiClient {
	class func fetch<T: Decodable>(_ route: Route, decoder: JSONDecoder,
								   completion: @escaping (CustomResult<[T]>) -> Void) {
		do {
			let request = try route.asURLRequest()

			let task = URLSession.shared.dataTask(with: request) { data, response, error in
				guard let data = data, error == nil else {
					DispatchQueue.main.async {
						completion(.failure(error))
					}
					return
				}
				do {
					let decodedResponse = try decoder.decode([T].self, from: data)
					DispatchQueue.main.async {
						completion(.success(decodedResponse))
					}
				} catch {
					DispatchQueue.main.async {
						completion(.failure(Errors.failToDecode))
					}
				}
			}
			task.resume()
		} catch {
			completion(.failure(error))
		}
	}
}
