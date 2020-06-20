//
//  GalleryViewController.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    lazy var cameraController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.modalPresentationStyle = .overFullScreen
        controller.delegate = self
        return controller
    }()
    var photos = [Photo]()
    let ui = GalleryView()
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        configureCollectionView()
        configureCommunication()
        setDummyData()
    }
    
    func setDummyData() {
        ui.collectionView.reloadData()
    }
    
    func configureSelf() {
        navigationItem.title = "Photos"
    }
    
    func configureCollectionView() {
        ui.collectionView.dataSource = self
        ui.collectionView.delegate = self
    }
    
    func configureCommunication() {
        ui.didTapCamera = { [weak self] in
            guard let cameraController = self?.cameraController else { return }
            self?.present(cameraController, animated: true)
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let galleryCell = cell as? GalleryCell
        let photo = photos[indexPath.item]
        galleryCell?.setImage(at: photo.imagePath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let galleryCell = cell as? GalleryCell
        galleryCell?.cancelImageRendering()
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        let photoVC = PhotoViewController(photo: photo)
        navigationController?.pushViewController(photoVC, animated: true)
    }
}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        print(image)
    }
}

extension GalleryViewController {
    enum Section {
        case main
    }
}
