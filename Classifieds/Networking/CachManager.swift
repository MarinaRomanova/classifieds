//
//  CachManager.swift
//  Classifieds
//
//  Created by Marina Romanova on 27/04/2021.
//

import UIKit

class CachManager {
	class func checkNetworkCache(request: URLRequest) -> Data? {
		if let cachedResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request),
		   let httpResponse = cachedResponse.response as? HTTPURLResponse {
			if httpResponse.statusCode < 400 {
				return cachedResponse.data
			}
		}
		return nil
	}
}
