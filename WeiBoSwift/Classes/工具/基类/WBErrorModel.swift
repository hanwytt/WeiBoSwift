//
//  WBErrorModel.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/28.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBErrorModel: NSObject {
    /// 当前请求
    var request: String?
    /// 错误代码
    var error_code: NSNumber?
    /// 错误信息
    var error: String?
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
