//
//  NSDate+Category.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/5/6.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import Foundation

/// 默认格式
private let defaultDateFormat: String = "yyyy-MM-dd HH:mm:ss"
/// 微博专用
private let statusDateFormat: String = "EEE MMM dd HH:mm:ss zzz yyyy"

extension NSDate {
    /// 时间转字符串
    func stringWithFormatter(dateFormat: String = defaultDateFormat) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.stringFromDate(self)
    }
    
    /// 字符串转时间
    class func dateWithStr(dateStr: String, dateFormat: String = defaultDateFormat) -> NSDate? {
        return dateStr.dateWithFormat(dateFormat)
    }
    
    /// 字符串转字符串
    class func strWithStr(dateStr: String, fromFormat: String = defaultDateFormat, toFormat: String = defaultDateFormat) -> String? {
        return dateStr.stringWithFormat(fromFormat, toFormat: toFormat)
    }
    
    /// 处理微博时间
    class func statusDateWithStr(dateStr: String) -> String? {
        return dateStr.dateWithFormat(statusDateFormat)?.descDate
    }

    /**
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     */
    var descDate:String{
        
        let calendar = NSCalendar.currentCalendar()
        
        // 1.判断是否是今天
        if calendar.isDateInToday(self)
        {
            // 1.0获取当前时间和系统时间之间的差距(秒数)
            let since = Int(NSDate().timeIntervalSinceDate(self))

            // 1.1是否是刚刚
            if since < 60
            {
                return "刚刚"
            }
            // 1.2多少分钟以前
            if since < 60 * 60
            {
                return "\(since/60)分钟前"
            }
            
            // 1.3多少小时以前
            return "\(since / (60 * 60))小时前"
        }
        
        // 2.判断是否是昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self)
        {
            // 昨天: HH:mm
            formatterStr =  "昨天:" +  formatterStr
        }else
        {
            // 3.处理一年以内
            formatterStr = "MM-dd " + formatterStr
            
            // 4.处理更早时间
            let comps = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if comps.year >= 1
            {
                formatterStr = "yyyy-" + formatterStr
            }
        }
        
        // 5.按照指定的格式将时间转换为字符串
        // 5.1.创建formatter
        let formatter = NSDateFormatter()
        // 5.2.设置时间的格式
        formatter.dateFormat = formatterStr
        // 5.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        
        // 5.4格式化
        return formatter.stringFromDate(self)
    }
}

extension String {
    /// 字符串转时间
    func dateWithFormat(dateFormat: String = defaultDateFormat) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.dateFromString(self)
    }
    
    /// 字符串转字符串
    func stringWithFormat(fromFormat: String = defaultDateFormat, toFormat: String = defaultDateFormat) -> String? {
        return self.dateWithFormat(fromFormat)?.stringWithFormatter(toFormat)
    }
}
