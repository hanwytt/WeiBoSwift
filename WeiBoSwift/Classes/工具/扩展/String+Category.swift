//
//  String+Category.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import Foundation

extension String{
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.stringByAppendingPathComponent((self as NSString).lastPathComponent)
    }
}