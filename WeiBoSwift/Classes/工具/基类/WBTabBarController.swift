//
//  WBTabBarController.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
import Alamofire

class WBTabBarController: UITabBarController {
    
    var refreshStatuses = false
    
    lazy var timer: NSTimer! = {
        let timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("requestUnreadCount"), userInfo: nil, repeats: true)
        return timer
    }()
    
    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.orangeColor()
        tabBar.backgroundImage = UIImage.init(named: "tabbar_background")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addChildVC(WBHomeViewController.init(), title: "首页", image: "tabbar_home")
        self.addChildVC(WBMessageViewController.init(), title: "消息", image: "tabbar_message_center")
        self.addChildVC(WBDiscoverViewController.init(), title: "发现", image: "tabbar_discover")
        self.addChildVC(WBProfileViewController.init(), title: "我", image: "tabbar_profile")
        
        timer.fire()
    }
    
    func addChildVC(vc: UIViewController, title: String, image: String) {
        vc.title = title;
        vc.tabBarItem.image = UIImage.init(named: image)
        vc.tabBarItem.selectedImage = UIImage.init(named: image + "_selected")
        let nav = WBNavigationController.init(rootViewController: vc)
        self.addChildViewController(nav)
    }

    func requestUnreadCount() {
        let path = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let parameters = ["access_token":authorizeModel.access_token!, "uid":authorizeModel.uid!, "unread_message":"0"]
        Alamofire.request(.GET, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                    let model = WBUnreadCountModel(dict: json as! [String: AnyObject])
                    let bar = self.tabBar.items![0]
                    if model.status <= 0 {
                        bar.badgeValue = nil
                    } else if model.status < 100 {
                        bar.badgeValue = "\(model.status)"
                    } else {
                        bar.badgeValue = "99+"
                    }
                } else {
                    print(result.error)
                }
        }
    }
}

extension WBTabBarController: UITabBarControllerDelegate {

}
