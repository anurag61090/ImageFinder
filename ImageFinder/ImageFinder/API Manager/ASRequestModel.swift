//
//  ASRequestModel.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation

// MARK: Class to Handle Request Models

class ASRequestModal: NSObject {
    
    var inputParameters: Dictionary<String,Any>?;
    var urlParameters: [String : String]?;
    var requestType = RequestType.POST;
    var baseUrl:String?
    var operationUrlString:String?
    var requestHeader:[String:String]?

    override init() {
        self.inputParameters = nil;
        self.urlParameters = nil;
        self.baseUrl = nil;
        self.operationUrlString = nil;
        self.requestHeader = nil;
    }
    
    init(requestIdentifier: String, iParams: Dictionary<String, Any>?, uParams: Dictionary<String, String>?, rType: RequestType) {
        
        self.inputParameters = iParams;
        self.urlParameters = uParams;
        requestType = rType
        self.baseUrl = nil;
        self.operationUrlString = nil;
        self.requestHeader = nil;
    }
}
