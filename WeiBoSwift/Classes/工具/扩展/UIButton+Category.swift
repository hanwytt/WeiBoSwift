//
//  UIButton+Category.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/5/7.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

extension UIButton {
    /// 首页微博cell按钮（转发、评论、赞）
    class func createStatusCellButton(title:String, imageName:String, target: AnyObject?, action: Selector) -> UIButton {
        let button = UIButton(type: UIButtonType.Custom)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
}