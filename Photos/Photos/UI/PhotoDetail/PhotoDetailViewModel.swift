//
//  PhotoDetailViewModel.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import Foundation

protocol PhotoDetailViewModelDelegate: class {
    func setPhoto(photo: Photo)
}

class PhotoDetailViewModel {
    
    weak var delegate: PhotoDetailViewModelDelegate?
    let mainPhoto: Photo
    
    required init() {
        
        let photo = Photo(id: "1", img_description: "stuff 1", width: 100, height: 100)
        
        mainPhoto = photo
    }
    
    func loadView() {
        
    }
    
}
