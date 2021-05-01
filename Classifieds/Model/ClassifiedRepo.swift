//
//  ClassifiiedRepo.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

final class ClassifiedRepo: ClassifiedDataSource {
	weak var listingsDelegate: ListingsDelegate?
	weak var filterDeleagate: FilterDelegate?

	private let apiClient: Api

	init(apiClient: Api) {
		self.apiClient = apiClient
	}

	var filters: [Filter] = [] {
		didSet {
			if oldValue != filters {
				let selectedFilters = filters.filter({ $0.isSelected })
				if selectedFilters.isEmpty {
					listingsDelegate?.onListingsFetched(listings)
				} else {
					let _listings = listings.filter({ selectedFilters.map {$0.categoryName}.contains($0.category.name) })
					listingsDelegate?.onListingsFetched(_listings)
				}
			}
		}
	}

	private(set) var listings = [Listing]() {
		didSet {
			listingsDelegate?.onListingsFetched(listings)
		}
	}

	func fetchListings() {
		var categories = [Category]()
		var listingsResp = [ListingsResponse]()
		listingsDelegate?.onLoadingStarted()

		let dispatchGroup: DispatchGroup = DispatchGroup()
		fetchData(dispatchGroup) { [weak self] (_categories: [Category]) in
			categories = _categories
			self?.filters = categories.map { $0.mapToFilter()}
		}

		fetchData(dispatchGroup, decoder: apiClient.getDateDecoder()) {_listings in
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
				if lhs.isUrgent && !rhs.isUrgent {
					return true
				} else if !lhs.isUrgent && rhs.isUrgent {
					return false
				} else if lhs.isUrgent == rhs.isUrgent {
					return lhs.creationDate > rhs.creationDate
				}

				return false
			}
		}
	}

	private func fetchData<T: Decodable>(_ dispatchGroup: DispatchGroup,
										 decoder: JSONDecoder = JSONDecoder(),
										 completion: @escaping ([T]) -> Void) {
		dispatchGroup.enter()
		apiClient.fetch(getRoute(for: T.self)!, decoder: decoder,
						completion: { (results: CustomResult<[T]>) in
			switch results {
			case .success(let items):
				completion(items)
			case .failure:
				return
			}
			dispatchGroup.leave()
		})
	}

	private func getRoute<T: Decodable>(for type: T.Type) -> Route? {
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

protocol ListingsDelegate: AnyObject {
	func onLoadingStarted()
	func onError(error: Error)
	func onListingsFetched(_ listings: [Listing])
}

protocol FilterDelegate: AnyObject {
	func applyFilters(_ filter: [Filter])
}

protocol ClassifiedDataSource {
	var listingsDelegate: ListingsDelegate? { get set }
	var filterDeleagate: FilterDelegate? { get set }
	var filters: [Filter] { get set}
	var listings: [Listing] { get }
	func fetchListings()
}
