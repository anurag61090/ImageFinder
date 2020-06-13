//
//  ASGetRequestHandler.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



struct ASGETRequestConstructor {
    
    static func getResponseForRequest(request: ASRequestModal, callback: @escaping NetworkClosure) {
        
        let url = request.baseUrl! + request.operationUrlString!
        let requestHeader = HTTPHeaders(request.requestHeader!)
        if let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            AF.request(encodedURL, method: .get, parameters: request.inputParameters, encoding: JSONEncoding.default, headers: requestHeader).responseJSON { (response) in
                       
               #if DEBUG
                   
                   print("************************ Request Start**************************");
                   print(response.request!)  // original URL request
                   print("************************ Request End **************************");
                   
                   print("************************ Response Data **************************");
                   let data = response.data
                   var datastring = "";
                   if(data != nil){
                       datastring = String(data: data!, encoding: String.Encoding.utf8)!
                       print(datastring)
                   }else{
                       print("\n\n valid response not found");
                   }
                   
                   print("************************ Response Results **************************");
                   print("************************ Response Results END **************************");
                   
               #endif
               
               let message: String? = nil
               var responseValue: AnyObject?
               var errorVal: NSError?
               var isSuccess: Bool = false

               switch response.result {
               case .success(let value):
                  responseValue = value as AnyObject
                  isSuccess = true
               case .failure(let error):
                  errorVal = error as NSError
                  isSuccess = false
               }

               let responsObject = ASNetObject(response: responseValue, status: response.response?.statusCode, err: errorVal, successful: isSuccess, message: message)
               callback(responsObject)
                          
            }
        } else {
            showAlertAppDelegate("", message: "URL not in correct format", buttonTitle: "OK", window: UIApplication.shared.windows.first!.rootViewController!)
        }
    }
}
