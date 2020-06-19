//
//  PhotoViewController.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let photo: String
    
    init(photo: String) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = nil
        view = imageView
    }
}
