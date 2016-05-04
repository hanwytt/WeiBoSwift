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

    var tableView: UITableView!
    var statuses: [WBStatusesModel] = []
    let cellIdentifier = "StatusesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = DefaultViewRGB
        createTableView()
        requestStatuses()
    }
    
    func createTableView() {
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.backgroundColor = DefaultViewRGB
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(WBHomeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    func requestStatuses() {
        let path = "https://api.weibo.com/2/statuses/public_timeline.json"
        let authorizeModel = WBAuthorizeModel.shareAuthorizeModel()
        let parameters = ["access_token":authorizeModel.access_token!, "count":"50", "page":"1", "base_app":"0"]
        Alamofire.request(.GET, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                    let model = WBHomeModel(dict: json as! [String : AnyObject])
                    if model.error == nil {
                        self.statuses = model.statuses
                        self.tableView.reloadData()
                    }
                } else {
                    print(result.error)
                }
        }
    }
}

extension WBHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! WBHomeTableViewCell
        let status = statuses[indexPath.section]
        
        let rowHeight = cell.rowHeight(status)
//        rowCache[status.id] = rowHeight
        return rowHeight
    }
}
