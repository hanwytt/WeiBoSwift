//
//  WBProfileViewController.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
import Alamofire

class WBProfileViewController: UIViewController {
    
    var tableView: UITableView!
    var logo: UIImageView!
    var name: UILabel!
    var desc: UILabel!
    
    let dataArr = [
        [
            ["icon":"", "title":"新的好友"],
            ["icon":"", "title":"微博等级"]
        ],
        [
            ["icon":"", "title":"我的相册"],
            ["icon":"", "title":"我的点评"],
            ["icon":"", "title":"我的赞"]
        ],
        [
            ["icon":"", "title":"微博支付"],
            ["icon":"", "title":"微博运动"]
        ],
        [
            ["icon":"", "title":"粉丝头条"],
            ["icon":"", "title":"粉丝服务"]
        ],
        [
            ["icon":"", "title":"草稿箱"]
        ],
        [
            ["icon":"", "title":"更多"]
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = RGB(241, 242, 243)
        createTableView()
        
        requestProfile()
    }
    
    func createTableView() {
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.backgroundColor = RGB(241, 242, 243)
        tableView.rowHeight = 48.0
        tableView.separatorInset = UIEdgeInsetsZero;
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 135))
        headerView.backgroundColor = UIColor.redColor()
        logo = UIImageView()
        logo.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(logo)
        name = UILabel()
        headerView.addSubview(name)
        desc = UILabel()
        headerView.addSubview(desc)
        logo.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(12)
            make.width.height.equalTo(60)
        }
        tableView.tableHeaderView = headerView
        
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    func requestProfile() {
        // 路径
        let path = "2/users/show.json"
        // 参数
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let params = ["access_token":authorizeModel.access_token!, "uid":authorizeModel.uid!]
        // 发送POST请求
//        NetworkTool.shareNetworkTool().GET(path, parameters: params, success: { (_, json) -> Void in
//            print(json)
//            let p = WBProfileModel(dict: json! as! [String : AnyObject])
//        }) { (_, error) -> Void in
//            print(error)
//        }
    }
}

extension WBProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArr.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = dataArr[section];
        return arr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        cell!.textLabel!.text = dataArr[indexPath.section][indexPath.row]["title"]
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}