//
//  PhotosListViewModel.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import Foundation

protocol PhotosListViewModelDelegate: class {
    
    func reloadPhotos()
    func updateRowWithPulledImage(indexPath: IndexPath)
}

class PhotosListViewModel {
    
    weak var delegate: PhotosListViewModelDelegate?
    let numberOfSections = 1
    var photos:[Photo] = []
    
    required init() {
        
    }
    
    func loadView(completion: (() -> ())?) {
        
        if HelperUtils.isInternetAvailable() == true {
            PhotosModelController.pullFeed(success: { (success) in
                self.photos = PhotosModelController.currentPhotos
                self.delegate?.reloadPhotos()
                
                if let completion = completion {
                    completion()
                }
                
            }) { (failedToPullFeed) in
                print("FailedToPullFeed: \(failedToPullFeed)")
            }
        }else {
            // TODO: Print error
        }
        
    }
    
    func setImage(indexPath: IndexPath) {
        
        guard let image_url = photos[indexPath.row].img_url else {
            print("No image URL set")
            return
        }
        
        PhotosModelController.pullImage(with: image_url[0], success: { (returnedImage) in
            
            self.photos[indexPath.row].mainImage = returnedImage
            self.delegate?.updateRowWithPulledImage(indexPath: indexPath)
            
        }) { (errorPullingImage) in
            print("errorPullingImage: \(errorPullingImage)")
        }
        
    }
    
    func pullMoreImages() {
        
        if HelperUtils.isInternetAvailable() == true {
            PhotosModelController.pullFeed(success: { (success) in
                self.photos = PhotosModelController.currentPhotos
                self.delegate?.reloadPhotos()
                
            }) { (failedToPullFeed) in
                print("FailedToPullFeed: \(failedToPullFeed)")
            }
        }else {
            // TODO: Print error
        }
        
    }
    
    
}
