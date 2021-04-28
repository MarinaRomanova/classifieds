//
//  ClassifiiedRepo.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

protocol ListingsDelegate: NSObject {
	func onLoadingStarted()
	func onError(error: Error)
	func onListingsFetched(_ listings: [Listing])
}

final class ClassifiedRepo {
	weak var listingsDeleagate: ListingsDelegate?

	func fetchListings() {

		var categories = [Category]()
		var listings = [ListingsResponse]()
		listingsDeleagate?.onLoadingStarted()

		let dispatchGroup: DispatchGroup = DispatchGroup()
		fetchData(dispatchGroup){ _categories in
			categories = _categories
		}

		fetchData(dispatchGroup, decoder: getDateDecoder()) {_listings in
			listings = _listings
		}

		dispatchGroup.notify(queue: .main) { [weak self] in
			var list = [Listing]()
			for response in listings {
				if let category = categories.first(where: { $0.id == response.categoryId }) {
					list.append(Listing(id: response.id, category: category, title: response.title,
										description: response.description, price: "\(response.price) €", //todo
										image: response.image, creationDate: response.creationDate, isUrgent: response.isUrgent))
				}
			}
			self?.listingsDeleagate?.onListingsFetched(list)
		}
	}

	private func getDateDecoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		return decoder
	}

	private func fetchData<T: Decodable>(_ dispatchGroup: DispatchGroup,
										 decoder: JSONDecoder = JSONDecoder(),
										 completion: @escaping ([T]) -> Void) {
		dispatchGroup.enter()
		ApiClient.fetch(getRoute(for: T.self)!, decoder: decoder,
						completion: { (results: CustomResult<[T]>) in
			switch results {
			case .success(let items):
				completion(items)
			case .failure(_):
				return
			}
			dispatchGroup.leave()
		})
	}

	func getRoute<T: Decodable>(for type: T.Type) -> Route? {
		switch T.self {
		case is ListingsResponse.Type:
			return Routes.listings
		case is Category.Type:
			return Routes.categories
		default:
			return nil
		}
	}
}
