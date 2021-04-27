//
//  ClassifiiedRepo.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

protocol ListingsDelegate {
	func onLoadingStarted()
	func onError(error: Error)
	func onListingsFetched(_ listings: [Listing])
}

final class ClassifiiedRepo { //: ObservableObject
//	private init() { }
//
//	static let shared = ClassifiiedRepo()

//	@Published var listings = [Listing]()
//	@Published var categories = [Category]()
	private var categories = [Category]()

	var listingsDeleagate: ListingsDelegate?

	func fetchListings() {
		fetchData(decoder: getDateDecoder()) { [weak self] _listings in
			//self?.listings = _listings
			self?.listingsDeleagate?.onListingsFetched(_listings)
		}
	}

	func fetchCategories() {
		fetchData { [weak self] _categories in
			self?.categories = _categories
		}
	}

	private func getDateDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		return decoder
	}
	private func fetchData<T: Decodable>(decoder: JSONDecoder = JSONDecoder(),
										 completion: @escaping ([T]) -> Void) {
		ApiClient.fetch(getRoute(for: T.self)!, decoder: decoder,
						completion: { (results: CustomResult<[T]>) in
			switch results {
			case .success(let items):
				completion(items)
			case .failure(_):
				return
			}
		})
	}

	func getRoute<T: Decodable>(for type: T.Type) -> Route? {
		switch T.self {
		case is Listing.Type:
			return Routes.listings
		case is Category.Type:
			return Routes.categories
		default:
			return nil
		}
	}
}
