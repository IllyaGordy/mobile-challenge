//
//  PhotosModelController.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-02.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AlamofireImage

class PhotosModelController: NSObject {

    static var currentPhotos: [Photo] = []
    
    static var lastPulledPage = 0
    static var pulledPages:[Int] = []
    static let numberOfPhotosPerPage = 20
    
    class func pullFeed(success:@escaping ((Bool) -> Void), failed:@escaping ((NSError) -> Void)) {
        
        let sendUrl = host + api_version + "/photos"
        
        let params = ["consumer_key": consumer_key,
                      "feature": "popular",
                      "page": lastPulledPage + 1,
                      "rpp": numberOfPhotosPerPage] as [String : Any]
        
        if !pulledPages.contains(lastPulledPage + 1) {
            
            Alamofire.request(sendUrl, method: .get, parameters: params).responseObject { (response: DataResponse<CallHelper>) in
                
                if let error = response.result.error {
                    let errorToPass = NSError.init(domain: error.localizedDescription, code: 0, userInfo: nil)
                    failed(errorToPass)
                }else {
                    
                    if response.response?.statusCode == 200 {
                        
                        if let returnValue = response.result.value {
                            
                            guard let photos = returnValue.photos else { return }
                            
                            self.currentPhotos.append(contentsOf: photos)
                            self.lastPulledPage += 1
                            self.pulledPages.append(self.lastPulledPage)
                            
                            success(true)
                            
                        }
                    }else {
                        
                        let errorMessage = "Wrong Login Information"
                        let errorToPass: NSError = NSError.init(domain: errorMessage, code: 0, userInfo: nil)
                        failed(errorToPass)
                        
                    }
                    
                }
                
            }
            
            
        }
        
        
        
    }
    
    
    class func pullImage(with stringUrl:String, success:@escaping ((UIImage) -> Void), failed:@escaping ((NSError) -> Void)) {
        
        Alamofire.request(stringUrl, method: .get, parameters: nil).responseImage { (responseImage) in
            
            if let image = responseImage.result.value {
                success(image)
            }else {
                let errorMessage = "Pulling Image Failed"
                let errorToPass: NSError = NSError.init(domain: errorMessage, code: 1, userInfo: nil)
                failed(errorToPass)
            }
        }
        
    }
}
