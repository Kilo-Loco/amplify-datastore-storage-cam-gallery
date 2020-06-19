//
//  GalleryView.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

class GalleryView: UIView {
    
    var didTapCamera: (() -> Void)?
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: .gridLayout
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.identifier)
        return view
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupSelf()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupSelf() {
        backgroundColor = .systemBackground
    }
    
    func setupSubviews() {
        addSubview(collectionView)
        addSubview(cameraButton)
        
        let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cameraButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20),
            cameraButton.widthAnchor.constraint(equalToConstant: 50),
            cameraButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func didTapCameraButton() {
        didTapCamera?()
    }
}
