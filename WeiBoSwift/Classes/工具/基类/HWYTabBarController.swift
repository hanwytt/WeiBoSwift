//
//  HWYTabBarController.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class HWYTabBarController: UITabBarController {

    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.orangeColor()
        tabBar.backgroundImage = UIImage.init(named: "tabbar_background")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addChildVC(ViewController.init(), title: "首页", image: "tabbar_home")
        self.addChildVC(ViewController.init(), title: "消息", image: "tabbar_message_center")
        self.addChildVC(ViewController.init(), title: "发现", image: "tabbar_discover")
        self.addChildVC(ViewController.init(), title: "我", image: "tabbar_profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addChildVC(vc: UIViewController, title: String, image: String) {
        vc.title = title;
        vc.tabBarItem.image = UIImage.init(named: image)
        vc.tabBarItem.selectedImage = UIImage.init(named: image + "_selected")
        let nav = HWYNavigationController.init(rootViewController: vc)
        self.addChildViewController(nav)
    }

}
