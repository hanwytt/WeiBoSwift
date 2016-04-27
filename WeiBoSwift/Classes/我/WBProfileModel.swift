//
//  WBProfileModel.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBProfileModel: WBErrorModel {
    /// 用户UID
    var id: NSNumber? = 0
    /// 字符串型的用户UID
    var idstr: String?
    /// 用户昵称
    var screen_name: String?
    /// 友好显示名称
    var name: String?
    /// 用户所在省级ID
    var province: Int = 0
    /// 用户所在城市ID
    var city: Int = 0
    /// 用户所在城市ID
    var location: String?
    /// 用户个人描述 description
    var desc: String?
    /// 用户博客地址
    var url: String?
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    /// 用户的微博统一URL地址
    var profile_url: String?
    /// 用户的个性化域名
    var domain: String?
    /// 用户的微号
    var weihao: String?
    /// 性别，m：男、f：女、n：未知
    var gender: String?
    /// 粉丝数
    var followers_count: Int = 0
    /// 关注数
    var friends_count: Int = 0
    /// 微博数
    var statuses_count: Int = 0
    /// 收藏数
    var favourites_count: Int = 0
    /// 用户创建（注册）时间
    var created_at: String?
    /// 是否允许所有人给我发私信，true：是，false：否
    var allow_all_act_msg: Bool?
    /// 是否允许标识用户的地理位置，true：是，false：否
    var geo_enabled: Bool?
    /// 是否是微博认证用户，即加V用户，true：是，false：否
    var verified: Bool?
    /// 用户备注信息，只有在查询用户关系时才返回此字段
    var remark: String?
    /// 用户的最近一条微博信息字段 详细
    var status: AnyObject?
    /// 是否允许所有人对我的微博进行评论，true：是，false：否
    var allow_all_comment: Bool?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    /// 用户头像地址（高清），高清头像原图
    var avatar_hd: String?
    /// 认证原因
    var verified_reason: String?
    /// 该用户是否关注当前登录用户，true：是，false：否
    var follow_me: Bool?
    /// 用户的在线状态，0：不在线、1：在线
    var online_status: Int = 0
    /// 用户的互粉数
    var bi_followers_count: Int = 0
    /// 用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
    var lang: String?
    
    override init(dict: [String: AnyObject])
    {
        super.init(dict: dict)
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
