//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import UIKit

class PhotoDetailViewController: BaseViewController {
    
    private let viewModel: PhotoDetailViewModel

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    required init(with model: PhotoDetailViewModel) {
        viewModel = model
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupPhoto()
        
        // Swipe Gestures
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func setupPhoto() {
        self.usernameLabel.text = viewModel.mainPhoto.username
        
        if viewModel.mainPhoto.mainImage != nil {
            
            photoView.image = viewModel.mainPhoto.mainImage
            
        }else if viewModel.mainPhoto.img_url != nil {
            
            photoView.image = UIImage.init(named: "emptyState")
            
            viewModel.setImage(indexPath: viewModel.currentPhotoIndex)
            
        }else {
            print("Image URL is empty -> do nothing")
            photoView.image = UIImage.init(named: "emptyState")
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            viewModel.swipeRight()
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            viewModel.swipeLeft()
        }
    }

}

extension PhotoDetailViewController: PhotoDetailViewModelDelegate {
    func resetImage(with photo: Photo) {
        setupPhoto()
    }
}
