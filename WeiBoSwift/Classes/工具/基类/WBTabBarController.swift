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
    
    var currentIndex = 0
    var homeVC: WBHomeViewController!
    
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
        homeVC = WBHomeViewController()
        self.addChildVC(homeVC, title: "首页", image: "tabbar_home")
        self.addChildVC(WBMessageViewController(), title: "消息", image: "tabbar_message_center")
        self.addChildVC(WBDiscoverViewController(), title: "发现", image: "tabbar_discover")
        self.addChildVC(WBProfileViewController(), title: "我", image: "tabbar_profile")
        delegate = self
        self.setValue(WBTabBar(), forKeyPath: "tabBar")
        
        timer.fire()
    }
    
    private func addChildVC(vc: UIViewController, title: String, image: String) {
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
                   self.setBadgeValue(item: 0, value: model.status)
                } else {
                    print(result.error)
                }
        }
    }
    
    func requestSetCount() {
        let path = "https://rm.api.weibo.com/2/remind/set_count.json"
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let parameters = ["access_token":authorizeModel.access_token!, "type":"mention_status"]
        Alamofire.request(.POST, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                    let model = WBErrorModel(dict: json as! [String: AnyObject])
                    if model.error == nil {
                        self.setBadgeValue(item: 0, value: 0)
                    }
                } else {
                    print(result.error)
                }
        }
    }
    
    func setBadgeValue(item item: Int, value: Int) {
        let bar = self.tabBar.items![item]
        if value <= 0 {
            bar.badgeValue = nil
        } else if value < 100 {
            bar.badgeValue = "\(value)"
        } else {
            bar.badgeValue = "99+"
        }
    }
}

extension WBTabBarController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let index = viewControllers?.indexOf(viewController) {
            if currentIndex == index {
                if currentIndex == 0 {
                    homeVC.requestStatuses()
                    requestSetCount()
                }
            } else {
                currentIndex = index
            }
        }
    }
}
