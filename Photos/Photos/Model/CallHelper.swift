//
//  CallHelper.swift
//  Photos
//
//  Created by Illya Gordiyenko on 2018-05-03.
//  Copyright © 2018 Illya Gordiyenko. All rights reserved.
//

import Foundation
import ObjectMapper

class CallHelper: NSObject, Mappable {
    
    var current_page: Int?
    var total_pages: Int?
    var total_items: Int?
    var photos: [Photo]?
    var filters: Data?
    var feature: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        current_page <- map["current_page"]
        total_pages <- map["total_pages"]
        total_items <- map["total_items"]
        photos <- map["photos"]
        filters <- map["filters"]
        feature <- map["feature"]
    }
    
}
