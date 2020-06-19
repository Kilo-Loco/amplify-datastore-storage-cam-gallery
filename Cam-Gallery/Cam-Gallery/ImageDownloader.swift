//
//  ImageDownloader.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import Foundation

enum ImageDownloader {
    
    static func getImageData(from imagePath: String?, completion: @escaping (Data) -> Void) -> URLSessionDataTask? {
        guard
            let imagePath = imagePath,
            let url = URL(string: imagePath)
            else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            completion(data)
        }
        
        task.resume()
        
        return task
    }
}
