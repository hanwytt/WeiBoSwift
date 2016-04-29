//
//  WBUnreadCountModel.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/27.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBUnreadCountModel: WBErrorModel {
    /// 新微博未读数
    var status: Int = 0
    /// 新粉丝数
    var follower: Int = 0
    /// 新评论数
    var cmt: Int = 0
    /// 新私信数
    var dm: Int = 0
    /// 新提及我的微博数
    var mention_status: Int = 0
    /// 新提及我的评论数
    var mention_cmt: Int = 0
    /// 微群消息未读数
    var group: Int = 0
    /// 私有微群消息未读数
    var private_group: Int = 0
    /// 新通知未读数
    var notice: Int = 0
    /// 新邀请未读数
    var invite: Int = 0
    /// 新勋章数
    var badge: Int = 0
    /// 相册消息未读数
    var photo: Int = 0
    /// {{{3}}} 
    var msgbox: Int = 0
    
    override init(dict: [String: AnyObject]) {
        super.init(dict: dict)
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
