//
//  PhotoViewController.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setImage(from: photo.imageKey)
        view = imageView
    }
}
