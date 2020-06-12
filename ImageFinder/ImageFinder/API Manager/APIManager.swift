//
//  APIManager.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD

class AppNetwork: NSObject {
    
    static let sharedInstance = AppNetwork();
    var requestConstructor : ASRequestConstructor;
    
    // Initialising Request Constructor
    override init() {
        requestConstructor = ASRequestConstructor();
    }
    
    // Fetch Response for the request
    func getNetworkResponseFor( _ request:ASRequestModal, callback: @escaping NetworkClosure){
        if AppReachability.isConnecteddToNetwork() {
            requestConstructor.processRequestFor(request, callback: callback);
        } else {
            showAlertAppDelegate("No Internet Connection", message: "There is no network connection", buttonTitle: "OK", window: UIApplication.shared.windows.first!.rootViewController!)
        }
    }
}


class APIManager: NSObject {
    
    // MARK: API to fetch Images
    class func getImagesList(page: Int, pageDataCount: Int, queryParameter: String, callback: @escaping NetworkClosure) {
        let paramDict: Dictionary<String, String> = ["{PAGE}": "\(page)",
                         "{DATA_COUNT}": "\(pageDataCount)",
                         "{QUERY_PARAMS}": queryParameter,
                         "{IMAGE_TYPE}": "photo",
                         "{KEY}": NetworkConstants.apiKey]
        let requestModel = ASRequestModal(requestIdentifier: "", iParams: nil, uParams: paramDict, rType: .GET)
        let appNetwork = AppNetwork.sharedInstance
        appNetwork.getNetworkResponseFor(requestModel, callback: callback)        
    }
}
