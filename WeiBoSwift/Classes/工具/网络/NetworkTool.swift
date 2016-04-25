//
//  NetworkTool.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
//typealias success = ((NSURLSessionDataTask, AnyObject?) -> Void)?
//typealias failure = ((NSURLSessionDataTask?, NSError) -> Void)?
class NetworkTool: AFHTTPSessionManager {
    static let tool:NetworkTool = {
        // 注意: baseURL一定要以/结尾
        let url = NSURL(string: "https://api.weibo.com/")
        let netTool = NetworkTool(baseURL: url)
        
        // 设置AFN能够接收得数据类型
        netTool.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return netTool
    }()
    
    // 获取单例的方法
    class func shareNetworkTool() -> NetworkTool {
        return tool
    }
    
//    func GET(URLString: String, parameters: AnyObject?, successAction: success, failureAction: failure) -> NSURLSessionDataTask? {
//        return GET(URLString, parameters: parameters, success: success, failure: failure)
//    }
}
