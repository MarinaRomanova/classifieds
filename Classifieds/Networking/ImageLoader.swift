//
//  ImageLoader.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import Foundation

final class ImageLoader {
	static let shared = ImageLoader()

	func loadImage(from path: String, completion: @escaping (String, Data) -> Void) {
		if let url = URL(string: path) {
			if let cache = CachManager.checkNetworkCache(request: URLRequest(url: url)) {
				completion(path, cache)
				return
			}
			let task = URLSession.shared.dataTask(with: url) { data, response, error in
				guard let httpResponse = response as? HTTPURLResponse, data != nil && error == nil else {
					return
				}
				if httpResponse.statusCode < 400 {
					DispatchQueue.main.async {
						completion(path, data!)
					}
				}
			}
			task.resume()
		}
	}
}
