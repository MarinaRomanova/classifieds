//
//  Listing.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

struct Listing: Decodable {
	let id: UInt64
	let categoryId: Int
	let title: String
	let description: String
	let price: Double
	let image: ListingImage?
	let creationDate: Date
	let isUrgent: Bool

	enum CodingKeys: String, CodingKey {
		case id, title, description, price
		case image = "images_url"
		case categoryId = "category_id"
		case creationDate = "creation_date"
		case isUrgent = "is_urgent"
	}
}

struct ListingImage: Decodable {
	let small: String?
	let thumb: String?
}
