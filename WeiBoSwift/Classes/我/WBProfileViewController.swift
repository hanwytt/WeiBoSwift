//
//  WBProfileViewController.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = RandomRGB()
        requestProfile()
        
    }
    
    func requestProfile() {
        // 路径
        let path = "2/users/show.json"
        // 参数
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let params = ["access_token":authorizeModel.access_token!, "uid":authorizeModel.uid!]
        // 发送POST请求
        NetworkTool.shareNetworkTool().GET(path, parameters: params, success: { (_, json) -> Void in
            print(json)
            let p = WBProfileModel(dict: json! as! [String : AnyObject])
        }) { (_, error) -> Void in
            print(error)
        }
    }
}
