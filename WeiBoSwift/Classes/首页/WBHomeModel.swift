//
//  WBHomeModel.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/29.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBHomeModel: WBErrorModel {
    var statuses: [WBStatusesModel] = []
    var advertises: [AnyObject] = []
    var ad: [AnyObject] = []
    var hasvisible: Bool = false
    var previous_cursor: Int = 0
    var next_cursor: Int = 0
    var total_number: Int = 0
    var interval: Int = 0
    var uve_blank: Int = 0
    var since_id: NSNumber = 0
    var max_id: NSNumber = 0
    var has_unread: Int = 0
    
    override init(dict: [String: AnyObject]) {
        super.init(dict: dict)
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "statuses" {
            let objArr = value as! [AnyObject]
            var temp: [WBStatusesModel] = []
            // 不能直接操作statuses
            for obj in objArr {
                let status = WBStatusesModel(dict: obj as! [String : AnyObject])
                temp.append(status)
            }
            statuses = temp
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
