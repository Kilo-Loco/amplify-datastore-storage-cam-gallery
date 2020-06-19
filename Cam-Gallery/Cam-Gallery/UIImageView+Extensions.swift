//
//  UIImageView+Extensions.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    func setImage(from imagePath: String?) -> URLSessionDataTask? {
        guard let imagePath = imagePath else { return nil }
        if let image = ImageCache.shared.getImage(for: imagePath) {
            
            self.image = image
            
            return nil
            
        } else {
            let task = ImageDownloader.getImageData(from: imagePath) { data in
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
            return task
        }
    }
}
