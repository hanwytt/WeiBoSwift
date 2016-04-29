//
//  WBHomeTableViewCell.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/29.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBHomeTableViewCell: UITableViewCell {
    lazy var contentText: UILabel! = {
        var contentText = UILabel()
        contentText.numberOfLines = 0
        return contentText
    }()
    
    lazy var line: UIView! = {
        var line = UIView()
        line.backgroundColor = DefaultLineRGB
        return line
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
//        accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        backgroundColor = UIColor.whiteColor()
        addUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加UI
    private func addUI() {
        contentView.addSubview(contentText)
        contentView.addSubview(line)
        contentText.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
        line.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
}
