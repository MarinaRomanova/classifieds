//
//  Routes.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

enum Routes: Route {
	case categories
	case listings

	var method: HTTPMethod {
		switch self {
		case .categories, .listings:
			return .get
		}
	}

	var path: String {
		switch self {
		case .categories:
			return BASE_URL + "categories.json"
		case .listings:
			return BASE_URL + "listing.json"
		}
	}

	func asURLRequest() throws -> URLRequest {
		guard let url = URL(string: path)  else {
			throw Errors.failedToBuildRequest
		}
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue

		return request
	}

	private var BASE_URL: String {
		"https://raw.githubusercontent.com/leboncoin/paperclip/master/"
	}
}

protocol Route {
	var method: HTTPMethod { get }
	var path: String { get }

	func asURLRequest() throws -> URLRequest
}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}
