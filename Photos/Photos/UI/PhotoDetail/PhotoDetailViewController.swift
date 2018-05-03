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

    @IBOutlet weak var titleLabel: UILabel!
    
    required init(with model: PhotoDetailViewModel) {
        viewModel = model
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = viewModel.mainPhoto.img_description
    }

}
