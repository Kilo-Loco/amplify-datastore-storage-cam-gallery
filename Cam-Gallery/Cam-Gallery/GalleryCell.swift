//
//  GalleryCell.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    var downloadImageOp: Operation?
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupSelf() {
        contentView.backgroundColor = .systemGray
    }
    
    func setupSubviews() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setImage(at imagePath: String) {
        downloadImageOp = imageView.setImage(from: imagePath)
        contentView.backgroundColor = UIColor(red: .random(in: 0 ... 1), green: .random(in: 0 ... 1), blue: .random(in: 0 ... 1), alpha: 1)
    }
    
    func cancelImageRendering() {
        downloadImageOp?.cancel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        cancelImageRendering()
    }
}

extension GalleryCell {
    static let identifier = String(describing: self)
}
