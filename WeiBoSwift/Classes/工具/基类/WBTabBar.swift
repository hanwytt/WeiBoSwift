//
//  WBTabBar.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBTabBar: UITabBar {
    
    lazy var compose:UIButton = {
        let compose = UIButton(type: UIButtonType.Custom)
        compose.setImage(UIImage.init(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        compose.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        compose.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        compose.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        compose.frame.size = compose.currentBackgroundImage!.size
        compose.addTarget(self, action: Selector("composeBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        return compose
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(compose)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.width;
        let height = self.bounds.height;
        
        compose.center = CGPointMake(width/2, height/2);
        
        var x:CGFloat = 0.0
        let y:CGFloat = 0.0
        let w:CGFloat = width/5.0
        let h:CGFloat = height
        
        var i = 0
        
        for view in subviews {
            if view is UIControl && view != compose {
                x = w * CGFloat(i>1 ? i+1 : i)
                view.frame = CGRect(x: x, y: y, width: w, height: h)
                i += 1
            }
        }
    }
    
    func composeBtnClick() {
        print("composeBtnClick")
    }
}