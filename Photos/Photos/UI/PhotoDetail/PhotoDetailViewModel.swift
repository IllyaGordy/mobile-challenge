//
//  PhotoDetailViewModel.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import Foundation

protocol PhotoDetailViewModelDelegate: class {
    func resetImage(with photo:Photo)
}

class PhotoDetailViewModel {
    
    weak var delegate: PhotoDetailViewModelDelegate?
    
    var currentPhotoIndex: IndexPath
    var mainPhoto: Photo
    var photos:[Photo] = []
    
    required init(with photoIndex: IndexPath, listOfOhotos:[Photo]) {
        
        photos = listOfOhotos
        mainPhoto = photos[photoIndex.row]
        currentPhotoIndex = photoIndex
    }
    
    func loadView() {
        
    }
    
    func setImage(indexPath: IndexPath) {
        
        guard let image_url = photos[indexPath.row].img_url else {
            print("No image URL set")
            return
        }
        
        PhotosModelController.pullImage(with: image_url[0], success: { (returnedImage) in
            
            self.photos[indexPath.row].mainImage = returnedImage
            self.delegate?.resetImage(with: self.photos[indexPath.row])
            
        }) { (errorPullingImage) in
            print("errorPullingImage: \(errorPullingImage)")
        }
        
    }
    
    func swipeRight() {
        if (currentPhotoIndex.row > 0) {
            currentPhotoIndex.row -= 1
            mainPhoto = photos[currentPhotoIndex.row]
            delegate?.resetImage(with: photos[currentPhotoIndex.row])
        }
    }
    
    func swipeLeft() {
        
        if (photos.count-1 > currentPhotoIndex.row) {
            currentPhotoIndex.row += 1
            mainPhoto = photos[currentPhotoIndex.row]
            delegate?.resetImage(with: photos[currentPhotoIndex.row])
        }else if (photos.count == currentPhotoIndex.row) {
            // Pull more photos and refresh
        }
    }
}
