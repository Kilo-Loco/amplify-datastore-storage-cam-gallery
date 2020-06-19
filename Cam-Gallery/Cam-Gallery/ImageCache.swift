//
//  ImageCache.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

class ImageCache: NSCache<NSString, UIImage> {
    
    static let shared = ImageCache()
    
    private override init() {
        super.init()
    }
    
    func cache(_ image: UIImage, for key: String) {
        setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        object(forKey: key as NSString)
    }
}
