//
//  WBHomeViewController.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/25.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh

/// 下拉、上拉
enum PullUpDown {
    case Up
    case Down
}

class WBHomeViewController: UIViewController {

    var unreadCount:SetUnreadCount?
    var tableView: UITableView!
    var max_id: NSNumber? = 0
    var since_id: NSNumber? = 0
    var statuses: [WBStatusesModel] = []
    let cellIdentifier = "StatusesCell"
    var isRequesting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = DefaultViewRGB
        createTableView()
        tableView.mj_header.beginRefreshing()
    }
    
    func createTableView() {
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.backgroundColor = DefaultViewRGB
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        //iOS7设置
//        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(WBHomeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        tableView.mj_header =  MJRefreshNormalHeader(refreshingBlock: { [unowned self] () -> Void in
            if self.isRequesting {
                self.tableView.mj_header.endRefreshing()
            } else {
                self.requestStatuses(.Down)
            }
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [unowned self] () -> Void in
            if self.isRequesting {
                self.tableView.mj_footer.endRefreshing()
            } else {
                self.requestStatuses(.Up)
            }
        })
    }
    
    func requestStatuses(pull: PullUpDown) {
        isRequesting = true
        let path = "https://api.weibo.com/2/statuses/home_timeline.json"
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        var parameters: [String: AnyObject] = [:]
        parameters["access_token"] = authorizeModel.access_token!
        switch pull {
        case .Down:
            if since_id != nil {
                parameters["since_id"] = since_id
            }
        case .Up:
            if max_id != nil {
                parameters["max_id"] = max_id
            }
        }
        parameters["count"] = 20
        parameters["page"] = 1
        parameters["base_app"] = 0
        Alamofire.request(.GET, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                    let model = WBHomeModel(dict: json as! [String : AnyObject])
                    if model.error == nil {
                        self.max_id = model.max_id
                        self.since_id = model.since_id
                        switch pull {
                        case .Down:
                            self.statuses.insertContentsOf(model.statuses, at: self.statuses.startIndex)
                        case .Up:
                            self.statuses.appendContentsOf(model.statuses)
                        }
                        self.unreadCount?(0, model.has_unread)
                        self.tableView.reloadData()
                    }
                } else {
                    print(result.error)
                }
            switch pull {
            case .Down:
                self.tableView.mj_header.endRefreshing()
            case .Up:
                self.tableView.mj_footer.endRefreshing()
            }
            self.isRequesting = false
        }
    }
}

extension WBHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        tableView.mj_footer?.hidden = statuses.count == 0
        return statuses.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! WBHomeTableViewCell
        let status = statuses[indexPath.section]
        cell.model = status
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //iOS7需要
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! WBHomeTableViewCell
//        let status = statuses[indexPath.section]
//        let rowHeight = cell.rowHeight(status)
//        return rowHeight
//    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if statuses.count > 0 && indexPath.section >= statuses.count - 1 {
//            requestStatuses(.Up)
//        }
//    }
}
