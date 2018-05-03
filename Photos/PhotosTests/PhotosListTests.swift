//
//  PhotosListTests.swift
//  PhotosTests
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import XCTest
@testable import Photos

class PhotosListTests: XCTestCase {
    
    var reloadPhotosStatus: Bool!
    var viewModel: PhotosListViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadView() {
        
        viewModel = PhotosListViewModel()
        
        viewModel.delegate = self
       
        
        let loadExpectation = expectation(description: "Load View Expectation")
        viewModel.loadView {
            loadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(reloadPhotosStatus)
    }
    
}

extension PhotosListTests: PhotosListViewModelDelegate {
    
    func reloadPhotos() {
        reloadPhotosStatus = true
    }
}
