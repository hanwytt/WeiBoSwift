//
//  WBAuthorizeModel.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBAuthorizeModel: NSObject, NSCoding {
    var access_token: String?
    var expires_in: NSNumber? {
        didSet{
            // 根据过期的秒数, 生成真正地过期时间
            expires_date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
            print(expires_date)
        }
    }
    var remind_in: NSNumber?
    var uid: NSNumber?
    var expires_date: NSDate?
    
    static let authorizeModel:WBAuthorizeModel = {
        if let model = WBAuthorizeModel.loadAuthorize() {
            return model
        } else {
            return WBAuthorizeModel()
        }
    }()
    
    // 获取单例的方法
    class func shareAuthorizeModel() -> WBAuthorizeModel {
        return authorizeModel
    }
    
    override init() {
        
    }
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {

    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(remind_in, forKey: "remind_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        remind_in = aDecoder.decodeObjectForKey("remind_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? NSNumber
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }
    
    static let filePath = "authorize.plist".cacheDir()
    
    func saveAuthorize() {
        NSKeyedArchiver.archiveRootObject(self, toFile: WBAuthorizeModel.filePath)
    }
    
    class func loadAuthorize() -> WBAuthorizeModel? {
        let model = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? WBAuthorizeModel
        // 判断授权信息是否过期
        if model?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedAscending {
            // 已经过期
            return nil
        }
        return model
    }
    
    class func isLogin() -> Bool {
        if WBAuthorizeModel.loadAuthorize() != nil {
            return true
        }
        return false
    }
    
    deinit {
        print("deinit")
    }
}
