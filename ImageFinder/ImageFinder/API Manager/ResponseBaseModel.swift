//
//  ResponseBaseModel.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation

// MARK: Struct to handle API Response

struct ASNetObject {
    
    let responseObject: AnyObject?
    let serverMessage: String?
    var responseString: String?
    let statusCode: Int?
    let error: NSError?
    var isSuccess: Bool?
    
    init(response: AnyObject?, status: Int?, err:NSError?, successful: Bool?,  message: String?) {
        
        self.responseObject = response
        self.statusCode = status
        self.error = err
        self.isSuccess = successful
        self.serverMessage = message
    }
}

