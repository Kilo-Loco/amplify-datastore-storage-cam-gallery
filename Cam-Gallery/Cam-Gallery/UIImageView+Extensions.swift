//
//  UIImageView+Extensions.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import Amplify
import UIKit

extension UIImageView {
    
    @discardableResult
    func setImage(from key: String) -> Operation? {
        
        if let image = ImageCache.shared.getImage(for: key) {
            self.image = image
            return nil
            
        } else {
            return Amplify.Storage.downloadData(key: key) { [weak self] result in
                guard case .success(let data) = result else { return }
                let image = UIImage(data: data)
                
                image.flatMap { ImageCache.shared.cache($0, for: key) }
                
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
