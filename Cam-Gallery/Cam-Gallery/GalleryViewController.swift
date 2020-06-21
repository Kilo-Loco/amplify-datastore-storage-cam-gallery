//
//  GalleryViewController.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import Amplify
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
        getPhotos()
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
    
    func getPhotos() {
        _ = Amplify.DataStore.query(Photo.self) { [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                }
                
            case .failure(let error):
                print("Could not fetch photos - \(error)")
            }
        }
    }
    
    func upload(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        print(imageData)
        let key = UUID().uuidString
        
        _ = Amplify.Storage.uploadData(key: key, data: imageData,
            progressListener: { progress in
                print("Progress: \(progress)")
            }, resultListener: { [weak self] (event) in
                switch event {
                case .success(let fileKey):
                    print("Completed: \(fileKey)")
                    
                    self?.savePhoto(with: fileKey)
                    
                case .failure(let storageError):
                    print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
            }
        })
    }
    
    func savePhoto(with key: String) {
        let photo = Photo(imageKey: key)
        
        _ = Amplify.DataStore.save(photo) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.photos.append(photo)
                    self?.ui.collectionView.reloadData()
                }
                
            case .failure(let error):
                print("Could not save photo - \(error)")
            }
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
        galleryCell?.setImage(at: photo.imageKey)
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
        upload(image)
    }
}

extension GalleryViewController {
    enum Section {
        case main
    }
}
