//
//  NetworkTools.swift
//  Alamofire_Test
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType: String {
    case get = "GET"
    case post = "POST"
}

class NetworkTools {
    
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, encoding: URLEncoding = URLEncoding.default, successCallback: @escaping (_ result: Any) -> (), failureCallback: @escaping (_ error: Error) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: encoding).responseJSON { (response) in
            guard let result = response.result.value else {
                failureCallback(response.result.error!)
                return
            }
            successCallback(result)
        }
    }
}
