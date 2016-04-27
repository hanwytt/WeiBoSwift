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
    let cellIdentifier = "cell"
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
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableHeaderView = headerView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(WBProfileTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    func headerView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 135))
        headerView.backgroundColor = UIColor.whiteColor()
        logo = UIImageView()
        logo.layer.cornerRadius = 30
        logo.layer.masksToBounds = true
        headerView.addSubview(logo)
        name = UILabel()
        headerView.addSubview(name)
        desc = UILabel()
        headerView.addSubview(desc)
        let line1 = UIView()
        line1.backgroundColor = RGB(235, 236, 237)
        headerView.addSubview(line1)
        let line2 = UIView()
        line2.backgroundColor = RGB(235, 236, 237)
        headerView.addSubview(line2)
        logo.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(12)
            make.width.height.equalTo(60)
        }
        name.snp_makeConstraints { (make) in
            make.left.equalTo(logo.snp_right).offset(12)
            make.centerY.equalTo(logo).offset(-10)
            make.height.equalTo(21)
        }
        desc.snp_makeConstraints { (make) in
            make.left.equalTo(name)
            make.top.equalTo(name.snp_bottom)
            make.height.equalTo(21)
        }
        line1.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(headerView)
            make.top.equalTo(logo.snp_bottom).offset(12)
            make.height.equalTo(1)
        }
        line2.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(headerView)
            make.height.equalTo(1)
        }
        return headerView
    }
    
    func requestProfile() {
        let path = "https://api.weibo.com/2/users/show.json"
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let parameters = ["access_token":authorizeModel.access_token!, "uid":authorizeModel.uid!]
        Alamofire.request(.GET, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                    let model = WBProfileModel(dict: json as! [String : AnyObject])
                    self.logo.sd_setImageWithURL(NSURL(string: model.profile_image_url!), placeholderImage: nil)
                    self.name.text = model.screen_name
                    self.desc.text = "我就是我"
                } else {
                    print(result.error)
                }
            }
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! WBProfileTableViewCell
        cell.title.text = dataArr[indexPath.section][indexPath.row]["title"]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}