//
//  ImageCache.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 14/07/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    var imageCache: [String: UIImage] = [:]
    
    func get(url: String) -> UIImage? {
        return imageCache[url]
    }
    
    func put(url: String, image: UIImage) {
        imageCache[url] = image
    }
    
}
