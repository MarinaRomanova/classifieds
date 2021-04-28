//
//  Listing.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

struct Listing {
	let id: UInt64
	let category: Category
	let title: String
	let description: String
	let price: String
	let image: ListingImage?
	let creationDate: Date
	let isUrgent: Bool
}
