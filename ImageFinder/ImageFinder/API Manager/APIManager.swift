//
//  APIManager.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation
import UIKit

class AppNetwork: NSObject {
    
    static let sharedInstance = AppNetwork();
    var requestConstructor : ASRequestConstructor;
    
    override init() {
        requestConstructor = ASRequestConstructor();
    }
    
    func getNetworkResponseFor( _ request:ASRequestModal, callback: @escaping NetworkClosure){
        if AppReachability.isConnecteddToNetwork() {
            requestConstructor.processRequestFor(request, callback: callback);
        } else {
            self.showAlertAppDelegate("No Internet Connection", message: "There is no network connection", buttonTitle: "OK", window: ((UIApplication.shared.delegate?.window)!)!)
        }
    }
    
    func showAlertAppDelegate(_ title : String,message : String,buttonTitle : String,window: UIWindow){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
}


class APIManager: NSObject {
    
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
