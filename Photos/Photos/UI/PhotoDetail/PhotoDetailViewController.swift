//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import UIKit

let popBackNotification = Notification.Name("popBackNotification")

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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    @IBAction func backButton(_ sender: UIButton) {
        
        self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.view.alpha = 1.0
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        
                        self.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                        self.view.alpha = 0.0
                        
        }, completion: {
            (value: Bool) in
            
            NotificationCenter.default.post(name: popBackNotification, object: nil, userInfo:["indexPath": self.viewModel.currentPhotoIndex])
        
            self.navigationController?.popViewController(animated: false)
            
            
        })
        
    }
}

extension PhotoDetailViewController: PhotoDetailViewModelDelegate {
    func resetImage(with photo: Photo) {
        setupPhoto()
    }
}
