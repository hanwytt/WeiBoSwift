//
//  Utility.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import MBProgressHUD

let KSCREENSIZE = UIScreen.mainScreen().bounds.size //屏幕尺寸
let KSCREEN_WIDTH = KSCREENSIZE.width
let KSCREEN_HEIGHT = KSCREENSIZE.height

func RGB(red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}

func RandomRGB() -> UIColor {
    return UIColor.init(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
}

let DefaultViewRGB = RGB(241, 242, 243)
let DefaultLineRGB = RGB(235, 236, 237)
