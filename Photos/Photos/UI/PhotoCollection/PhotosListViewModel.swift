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
}

class PhotosListViewModel {
    
    weak var delegate: PhotosListViewModelDelegate?
    let numberOfSections = 1
    var photos:[Photo] = []
    
    required init() {
        
    }
    
    func loadView() {
        
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
