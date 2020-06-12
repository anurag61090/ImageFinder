//
//  ASRequestConstructor.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation
import UIKit

class ASRequestConstructor {
    
    func processRequestFor(_ request: ASRequestModal, callback:@escaping NetworkClosure){
        var request = request

        self.processRequestInfo(&request);
    
        switch request.requestType{

        case .GET:
            ASGETRequestConstructor.getResponseForRequest(request: request, callback: callback);
                break;

        case .POST:
            print("Handle POST Request Here")

        case .DELETE:
            print("Handle DELETE Request Here")
            
        case .PUT:
            print("Handle PUT Request Here")
            
        default:
            break;
            
        }
    }

    
    func handleNetworkError( netResponse: ASNetObject, callback: NetworkClosure){
        
        if((netResponse.isSuccess == false)){
            if( (netResponse.serverMessage != nil) && ((netResponse.serverMessage?.count)! > 0) ){
                
                let appDelegate = UIApplication.shared.delegate
                self.showAlertAppDelegate("Ooops!!!", message: netResponse.serverMessage ?? "An Error Occured", buttonTitle: "OK", window: (appDelegate?.window)!!)
                callback(netResponse);
                
            }else if(netResponse.error != nil){
                
                let appDelegate = UIApplication.shared.delegate
                let userInfo = netResponse.error?.userInfo
                
                if(userInfo != nil){
                    let errorMsg = userInfo?["NSLocalizedDescription"] as? String
                    if(errorMsg != nil){
                        self.showAlertAppDelegate("Ooops!!!", message: errorMsg ?? "An Error Occured", buttonTitle: "OK", window: (appDelegate?.window)!!)
                        callback(netResponse);
                    }else{
                        
                        callback(netResponse);
                    }
                }
            }else{
                callback(netResponse);
            }
        }
        else{
            callback(netResponse);
        }
    }

    
    func showAlertAppDelegate(_ title : String,message : String,buttonTitle : String,window: UIWindow){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func processRequestInfo(_ requestModal : inout ASRequestModal){
        var operationUrl = OperationalURLs.searchUrl
        
        if let isTrue = requestModal.urlParameters{
            if(isTrue.count > 0){
                var inputUrl = operationUrl;
                for (key, value) in requestModal.urlParameters!{
                    inputUrl = inputUrl.replacingOccurrences(of: key, with: value);
                }
                operationUrl = inputUrl;
            }
        }else{
            requestModal.operationUrlString = operationUrl;
        }
        requestModal.operationUrlString = operationUrl ;
        requestModal.baseUrl = NetworkConstants.baseURL
        requestModal.operationUrlString = operationUrl
        requestModal.requestHeader = ["Content-Type": "application/json"]
    }
}

