//
//  HWYNavigationController.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class HWYNavigationController: UINavigationController {

    override class func initialize() {
        let navBar = UINavigationBar.appearance()
//        navBar.backgroundImage = UIImage.init(named: "tabbar_background")
        navBar.setBackgroundImage(UIImage.init(named: "navigationbar_background"), forBarMetrics: UIBarMetrics.CompactPrompt)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
