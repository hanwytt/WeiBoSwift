//
//  NSDate+Category.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/5/6.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import Foundation

extension NSDate {
    func stringWithFormatter() -> String {
        return self.stringWithFormatter("yyyy-MM-dd HH:mm:ss")
    }
    
    func stringWithFormatter(dateFormat: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.stringFromDate(self)
    }
}

extension String {
    func dateWithFormatter(dateFormat: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.dateFromString(self)
    }
    
    func stringWithFormatter(dateFormat: String) -> String {
        if let date = self.dateWithFormatter(dateFormat) {
            return date.stringWithFormatter()
        } else {
            return ""
        }
    }
    
    func stringWithFormatterToFormatter(dateFormat: String, toFormatter: String) -> String {
        if let date = self.dateWithFormatter(dateFormat) {
            return date.stringWithFormatter(toFormatter)
        } else {
            return ""
        }
    }
}
