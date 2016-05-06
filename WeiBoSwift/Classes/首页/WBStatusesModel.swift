//
//  WBStatusesModel.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/29.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBStatusesModel: NSObject {
    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: NSNumber? = 0
    /// 微博MID
    var mid: String?
    /// 字符串型的微博ID
    var idstr: String?
    /// 微博信息内容
    var text: String?
    var textLength: Int = 0
    var source_allowclick: Bool = false
    var source_type: Int = 0
    /// 微博来源
    var source: String?
    /// 是否已收藏，true：是，false：否
    var favorited: Bool = false
    /// 是否被截断，true：是，false：否
    var truncated: Bool = false
    /// （暂未支持）回复ID
    var in_reply_to_status_id: String?
    /// （暂未支持）回复人UID
    var in_reply_to_user_id: String?
    /// （暂未支持）回复人昵称
    var in_reply_to_screen_name: String?
    var pic_urls: [AnyObject]?
    /// 缩略图片地址，没有时不返回此字段
    var thumbnail_pic: String?
    /// 中等尺寸图片地址，没有时不返回此字段
    var bmiddle_pic: String?
    /// 原始图片地址，没有时不返回此字段
    var original_pic: String?
    /// 地理信息字段 详细
    var geo: AnyObject?
    /// 微博作者的用户信息字段 详细
    var user: WBUserModel?
    /// 被转发的原微博信息字段，当该微博为转发微博时返回 详细
    var retweeted_status: WBStatusesModel?
    /// 转发数
    var reposts_count: Int = 0
    /// 评论数
    var comments_count: Int = 0
    /// 表态数
    var attitudes_count: Int = 0
    var isLongText: Bool = false
    /// 暂未支持
    var mlevel: Int = 0
    /// 微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
    var visible: AnyObject?
    /// 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    var pic_ids: AnyObject?
    /// 微博流内的推广微博ID
    var ad: [AnyObject]?
    var biz_feature: NSNumber? = 0
    var page_type: Int = 0
    var darwin_tags: [AnyObject]?
    var hot_weibo_tags: [AnyObject]?
    var text_tag_tips: [AnyObject]?
    var rid: String?
    var userType: Int = 0
    var cardid: String?

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "user" {
            user = WBUserModel(dict: value as! [String : AnyObject])
        } else if key == "retweeted_status" {
            retweeted_status = WBStatusesModel(dict: value as! [String : AnyObject])
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
