//
//  WBTabBarController.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBTabBarController: UITabBarController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addChildVC(vc: UIViewController, title: String, image: String) {
        vc.title = title;
        vc.tabBarItem.image = UIImage.init(named: image)
        vc.tabBarItem.selectedImage = UIImage.init(named: image + "_selected")
        let nav = WBNavigationController.init(rootViewController: vc)
        self.addChildViewController(nav)
    }

}
