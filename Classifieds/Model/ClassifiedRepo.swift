//
//  ClassifiiedRepo.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

protocol ListingsDelegate: AnyObject {
	func onLoadingStarted()
	func onError(error: Error)
	func onListingsFetched(_ listings: [Listing])
}

protocol FilterDelegate: AnyObject {
	func applyFilters(_ filter: [Filter])
}

final class ClassifiedRepo {
	weak var listingsDeleagate: ListingsDelegate?
	weak var filterDeleagate: FilterDelegate?

	var filters: [Filter] = [] {
		didSet {
			if oldValue != filters {
				let selectedFilters = filters.filter({ $0.isSelected })
				if selectedFilters.isEmpty {
					listingsDeleagate?.onListingsFetched(listings)
				} else {
					let _listings = listings.filter({ selectedFilters.map{$0.categoryName}.contains($0.category.name) })
					listingsDeleagate?.onListingsFetched(_listings)
				}
			}
		}
	}

	private(set) var listings = [Listing]() {
		didSet {
			listingsDeleagate?.onListingsFetched(listings)
		}
	}

	func fetchListings() {
		var categories = [Category]()
		var listingsResp = [ListingsResponse]()
		listingsDeleagate?.onLoadingStarted()

		let dispatchGroup: DispatchGroup = DispatchGroup()
		fetchData(dispatchGroup){ [weak self] (_categories: [Category]) in
			categories = _categories
			self?.filters = categories.map { $0.mapToFilter()}
		}

		fetchData(dispatchGroup, decoder: getDateDecoder()) {_listings in
			listingsResp = _listings
		}

		dispatchGroup.notify(queue: .main) { [weak self] in
			var list = [Listing]()
			for response in listingsResp {
				if let category = categories.first(where: { $0.id == response.categoryId }) {
					list.append(response.mapToDomain(with: category))
				}
			}
			self?.listings = list.sorted { lhs, rhs -> Bool in
				lhs.creationDate > rhs.creationDate
			}
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

struct Filter: Equatable {
	let categoryName: String
	var isSelected: Bool = false
}
