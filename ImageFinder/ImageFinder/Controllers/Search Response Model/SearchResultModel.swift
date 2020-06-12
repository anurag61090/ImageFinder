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
    var previewWidth: Int64 = -1
    var previewHeight: Int64 = -1
    var webformatURL: String = ""
    var webformatWidth: Int64 = -1
    var webformatHeight: Int64 = -1
    var largeImageURL: String = ""
    var imageWidth: Int64 = -1
    var imageHeight: Int64 = -1
    var imageSize: Int64 = -1
    var views: Int64 = -1
    var downloads: Int64 = -1
    var favorites: Int64 = -1
    var likes: Int64 = -1
    var comments: Int64 = -1
    var user_id: Int64 = -1
    var user: String = ""
    var userImageURL: String = ""
    
    init(responseDict: Dictionary<String, Any>) {
        
        if let respVal = responseDict["id"] as? Int64 {
            self.id = respVal
        }
        
        if let respVal = responseDict["previewWidth"] as? Int64 {
            self.previewWidth = respVal
        }
        
        if let respVal = responseDict["previewHeight"] as? Int64 {
            self.previewHeight = respVal
        }
        
        if let respVal = responseDict["webformatWidth"] as? Int64 {
            self.webformatWidth = respVal
        }
        
        if let respVal = responseDict["webformatHeight"] as? Int64 {
            self.webformatHeight = respVal
        }
        
        if let respVal = responseDict["imageWidth"] as? Int64 {
            self.imageWidth = respVal
        }
        
        if let respVal = responseDict["imageHeight"] as? Int64 {
            self.imageHeight = respVal
        }
        
        if let respVal = responseDict["imageSize"] as? Int64 {
            self.imageSize = respVal
        }
        
        if let respVal = responseDict["views"] as? Int64 {
            self.views = respVal
        }
        
        if let respVal = responseDict["downloads"] as? Int64 {
            self.downloads = respVal
        }
        
        if let respVal = responseDict["likes"] as? Int64 {
            self.likes = respVal
        }
        
        if let respVal = responseDict["comments"] as? Int64 {
            self.comments = respVal
        }
        
        if let respVal = responseDict["user_id"] as? Int64 {
            self.user_id = respVal
        }
        
        if let respVal = responseDict["favorites"] as? Int64 {
            self.favorites = respVal
        }
        
        if let respVal = responseDict["largeImageURL"] as? String {
            self.largeImageURL = respVal
        }
        
        if let respVal = responseDict["pageURL"] as? String {
            self.pageURL = respVal
        }
        
        if let respVal = responseDict["type"] as? String {
            self.type = respVal
        }
        
        if let respVal = responseDict["tags"] as? String {
            self.tags = respVal
        }
        
        if let respVal = responseDict["previewURL"] as? String {
            self.previewURL = respVal
        }
        
        if let respVal = responseDict["webformatURL"] as? String {
            self.webformatURL = respVal
        }
        
        if let respVal = responseDict["user"] as? String {
            self.user = respVal
        }
        
        if let respVal = responseDict["userImageURL"] as? String {
            self.userImageURL = respVal
        }
    }
}
