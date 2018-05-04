//
//  PhotosListViewController.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import UIKit

private let gridPhotoCellIdentified = "GridPhotoCellIdentified"

class PhotosListViewController: BaseViewController {

    private let viewModel: PhotosListViewModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    required init(with model: PhotosListViewModel) {
        viewModel = model
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadView {
            self.reloadPhotos()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GridPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gridPhotoCellIdentified)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onPopBack(notification:)), name: popBackNotification, object: nil)

    }
    
    @objc func onPopBack(notification:Notification) {
        
        if let userInfo = notification.userInfo, let indexPath = userInfo["indexPath"] as? IndexPath {
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        }
    }
}

extension PhotosListViewController: PhotosListViewModelDelegate {
    func reloadPhotos() {
        self.collectionView.reloadData()
    }
    
    func updateRowWithPulledImage(indexPath: IndexPath) {
        self.collectionView.reloadItems(at: [indexPath])
    }
}

extension PhotosListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridPhotoCellIdentified, for: indexPath) as! GridPhotoCollectionViewCell
        
        if viewModel.photos[indexPath.row].mainImage != nil {
        
            cell.photoView.image = viewModel.photos[indexPath.row].mainImage
            
        }else if viewModel.photos[indexPath.row].img_url != nil {
            
            cell.photoView.image = UIImage.init(named: "emptyState")
            viewModel.setImage(indexPath: indexPath)
            
        }else {
            print("Image URL is empty -> do nothing")
            cell.photoView.image = UIImage.init(named: "emptyState")
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.photos.count - 1 {
            viewModel.pullMoreImages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performPushAnimation(indexPath: indexPath)
    }
    
    func performPushAnimation(indexPath: IndexPath) {
        let photoDetailVM = PhotoDetailViewModel(with: indexPath, listOfOhotos: viewModel.photos)
        let photoDetailVC = PhotoDetailViewController(with: photoDetailVM)
        
        let window = UIApplication.shared.delegate?.window!
        // TODO: set the destination View center based on the cell
        // destinationView?.center = CGPoint(x: (sourceView?.center.x)!, y: (sourceView?.center.y)! - (destinationView?.center.y)!)
        
        window?.insertSubview(photoDetailVC.view, aboveSubview: self.view)
        
        
        photoDetailVC.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        photoDetailVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.3,
                       animations: {

                        photoDetailVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        photoDetailVC.view.alpha = 1.0

        }, completion: {
            (value: Bool) in

            self.navigationController?.pushViewController(photoDetailVC, animated: false)


        })
    }
}

fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
fileprivate let itemsPerRow: CGFloat = 3
extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
