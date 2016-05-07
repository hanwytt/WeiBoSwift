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
    var statuses_count : UILabel!
    var friends_count: UILabel!
    var followers_count: UILabel!
    let cellIdentifier = "UserCell"
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
        view.backgroundColor = DefaultViewRGB
        createTableView()
        
        requestProfile()
    }
    
    func createTableView() {
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.backgroundColor = DefaultViewRGB
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
        let bottomView = UIView()
        headerView.addSubview(bottomView)
        let line1 = UIView()
        line1.backgroundColor = DefaultLineRGB
        bottomView.addSubview(line1)
        let line2 = UIView()
        line2.backgroundColor = DefaultLineRGB
        bottomView.addSubview(line2)
        statuses_count = UILabel()
        statuses_count.textAlignment = NSTextAlignment.Center
        bottomView.addSubview(statuses_count)
        friends_count = UILabel()
        friends_count.textAlignment = NSTextAlignment.Center
        bottomView.addSubview(friends_count)
        followers_count = UILabel()
        followers_count.textAlignment = NSTextAlignment.Center
        bottomView.addSubview(followers_count)
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
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(logo.snp_bottom).offset(12)
            make.left.right.bottom.equalTo(headerView)
        }
        line1.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(0)
            make.height.equalTo(1)
        }
        line2.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        statuses_count.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(0)
        }
        friends_count.snp_makeConstraints { (make) in
            make.left.equalTo(statuses_count.snp_right)
            make.centerY.equalTo(0)
            make.width.equalTo(statuses_count)
        }
        followers_count.snp_makeConstraints { (make) in
            make.left.equalTo(friends_count.snp_right)
            make.right.equalTo(0)
            make.centerY.equalTo(0)
            make.width.equalTo(friends_count)
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
                    let model = WBUserModel(dict: json as! [String : AnyObject])
                    if model.error == nil {
                        self.logo.sd_setImageWithURL(NSURL(string: model.profile_image_url!), placeholderImage: UIImage(named: "avator_default"))
                        self.name.text = model.name
                        self.desc.text = model.desc
                        self.statuses_count.text = "\(model.statuses_count)"
                        self.friends_count.text = "\(model.friends_count)"
                        self.followers_count.text = "\(model.followers_count)"
                    }
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