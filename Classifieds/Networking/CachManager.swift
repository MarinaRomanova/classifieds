//
//  CachManager.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class CachManager {
	static var cache = NSCache<NSString, NSData>()

	class func setImageCache(_ url: String, _ data: Data) {
		cache.setObject(NSData(data: data), forKey: url as NSString)
	}

	class func getImageCache(_ url: String) -> Data? {
		cache.object(forKey: url as NSString) as Data?	}
}
