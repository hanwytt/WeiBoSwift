//
//  WBHomeViewController.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
import Alamofire

class WBHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = RandomRGB()
        requestStatuses()
    }
    
    func requestStatuses() {
        let path = "https://api.weibo.com/2/statuses/public_timeline.json"
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let parameters = ["access_token":authorizeModel.access_token!, "count":"50", "page":"1", "base_app":"0"]
        Alamofire.request(.GET, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                } else {
                    print(result.error)
                }
        }
    }
}
