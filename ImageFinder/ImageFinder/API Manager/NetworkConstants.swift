//
//  NetworkConstants.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import Foundation

typealias NetworkClosure = (_ netResponse: ASNetObject)-> Void

enum RequestType: String {
    
    case NONE
    case GET
    case POST
    case PUT
    case DELETE
}

struct NetworkConstants {
    
    static let baseURL = "https://pixabay.com/api/"
    static let apiKey = "16986734-d9e6afc288ad9a9cec5bd531c"
}

struct OperationalURLs {
    
    static let searchUrl = "?key={KEY}&image_type={IMAGE_TYPE}&page={PAGE}&per_page={DATA_COUNT}&q={QUERY_PARAMS}"
}
