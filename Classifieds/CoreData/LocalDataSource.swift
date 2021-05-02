//
//  LocalDataSource.swift
//  Classifieds
//
//  Created by Marina Romanova on 02/05/2021.
//

import UIKit
import CoreData

class LocalDataSource: ClassifiedDataSource {
	var filters: [Filter] = [] {
		didSet {
			if oldValue != filters {
				//TODO
				//listingsDelegate?.onListingsFetched(_listings)
			}
		}
	}

	init() {
		fetchListings()
	}

	func fetchListings() {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let managedContext = appDelegate.persistentContainer.viewContext
		let request = NSFetchRequest<Listing_>(entityName: "Listing_")
		if let listings_ = try? managedContext.fetch(request), !listings_.isEmpty {
			self.listings_ = listings_
		}
	}

	func save(listingResp: ListingsResponse, category: Category) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Listing_", in: managedContext)!

		save(category: category)
		save(image: listingResp.image)

		let listing_ = NSManagedObject(entity: entity, insertInto: managedContext)

		listing_.setValue(listingResp.creationDate, forKeyPath: "creationDate")
		listing_.setValue(listingResp.description, forKeyPath: "descript")
		listing_.setValue(listingResp.id, forKeyPath: "id")
		listing_.setValue(listingResp.isUrgent, forKeyPath: "isUrgent")
		listing_.setValue(listingResp.price, forKeyPath: "price")

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}

	weak var listingsDelegate: ListingsDelegate?
	weak var filterDeleagate: FilterDelegate?

	private(set) var listings = [Listing]() {
		didSet {
			listingsDelegate?.onListingsFetched(listings)
		}
	}

	var listings_: [Listing_] = [] {
		didSet {
			if oldValue != listings_ {
				listings_.forEach { entity in
					if let category = entity.category?.mapToDomain() {
						listings.append(entity.mapToDomain(with: category))
					}
				}
			}
		}
	}

	func fetchCategories() -> [Category_] {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
		let managedContext = appDelegate.persistentContainer.viewContext
		let request = NSFetchRequest<Category_>(entityName: "Category_")
		return (try? managedContext.fetch(request)) ?? []
	}

	func save(category: Category) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Category_", in: managedContext)!
		let category_ = NSManagedObject(entity: entity, insertInto: managedContext)
		category_.setValue(category.name, forKeyPath: "name")
		category_.setValue(category.id, forKeyPath: "id")

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}

	func save(image: ListingImage?) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		let managedContext = appDelegate.persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Image_", in: managedContext)!
		let image_ = NSManagedObject(entity: entity, insertInto: managedContext)
		if let image = image {
			image_.setValue(image.small, forKeyPath: "small")
			image_.setValue(image.thumb, forKeyPath: "thumb")
		}

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
}


extension Listing_ {
	func mapToDomain(with category: Category) -> Listing {
		Listing(id: UInt64(self.id), category: category, title: self.title!,
				description: self.description, price: "\(self.price) €",
				image: ListingImage(small: self.image?.small, thumb: self.image?.thumb),
				creationDate: self.creationDate!, isUrgent: self.isUrgent)
	}
}

extension Category_ {
	func mapToDomain() -> Category {
		Category(id: Int(self.id), name: self.name!)
	}
}
