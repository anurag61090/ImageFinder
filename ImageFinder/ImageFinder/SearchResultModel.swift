//
//  SearchResultModel.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation

struct SearchResultModel {
    
    var total: Int64 = -1
    var totaHits: Int = -1
    var resultsArray: [SearchResult] = []
    
    init(responseDict: Dictionary<String, AnyObject>) {
        
        if let respVal = responseDict["total"] as? Int64 {
            self.total = respVal
        }
        
        if let respVal = responseDict["totalHits"] as? Int {
            self.totaHits = respVal
        }
        
        if let respVal = responseDict["hits"] as? Array<Dictionary<String, AnyObject>> {
            for respDict in respVal {
                let searchResult = SearchResult(responseDict: respDict)
                self.resultsArray.append(searchResult)
            }
        }
    }
}

struct SearchResult {
    
    var id: Int64 = -1
    var pageURL: String = ""
    var type: String = ""
    var tags: String = ""
    var previewURL: String = ""
    var previewWidth: Int64 = 150
    var previewHeight: Int64 = 99
    var webformatURL: String = ""
    var webformatWidth: Int64 = 640
    var webformatHeight: Int64 = 425
    var largeImageURL: String = ""
    var imageWidth: Int64 = 2144
    var imageHeight: Int64 = 1424
    var imageSize: Int64 = 668020
    var views: Int64 = 943165
    var downloads: Int64 = 172187
    var favorites: Int64 = 1656
    var likes: Int64 = 2142
    var comments: Int64 = 290
    var user_id: Int64 = 1107275
    var user: String = ""
    var userImageURL: String = ""
    
    init(responseDict: Dictionary<String, Any>) {
        
    }
}
