//
//  NetworkTools.swift
//  News
//
//  Created by Raymond on 2016/12/22.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit
import Alamofire

// MARK:- 请求方式
enum MethodType {
    case get
    case post
}

// MARK:- 网络工具类
class NetworkTools {
    /// 发送网络请求的函数
    ///
    /// - Parameters:
    ///   - URLString: 请求url
    ///   - type: 请求方式
    ///   - parameters: 请求参数
    ///   - finishedCallback: 发送请求后的回调闭包
    class func requsetData(URLString : String, type : MethodType, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 2.校验是否有结果
            guard let result = response.result.value else {
                print(response.result.error ?? "请求超时")
                return
            }
            // 3.将结果回调回去
            finishedCallback(result)
        }
    }
}
