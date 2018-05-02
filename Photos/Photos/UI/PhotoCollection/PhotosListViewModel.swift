//
//  PhotosListViewModel.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import Foundation

protocol PhotosListViewModelDelegate: class {
    
    func setPhotos(photos: [Photo])
}

class PhotosListViewModel {
    
    weak var delegate: PhotosListViewModelDelegate?
    let numberOfSections = 1
    
    required init() {
        
    }
    
    func loadView() {
        delegate?.setPhotos(photos: dummyPhotos())
    }
    
    
    func dummyPhotos() -> [Photo] {
        
        var tempPhotos:[Photo] = []
        let count = 5
        
        for index in 0...count {
            
            let photo = Photo(id: index, name: "Photo \(index)", description: "Description", created_at: nil, image_url: "stuff", for_sale: true, camera: "some camera")
            tempPhotos.append(photo)
        }
        
        return tempPhotos
        
    }
    
}
