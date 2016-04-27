//
//  WBProfileTableViewCell.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/27.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBProfileTableViewCell: UITableViewCell {
    lazy var icon: UIImageView! = {
        var icon = UIImageView()
        return icon
    }()
    
    lazy var title: UILabel! = {
        var title = UILabel()
        return title
    }()
    
    lazy var line: UIView! = {
        var line = UIView()
        line.backgroundColor = DefaultLineRGB
        return line
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
        accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        backgroundColor = UIColor.whiteColor()
        addUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加UI
    private func addUI() {
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(line)
        icon.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(12)
            make.width.height.equalTo(24)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(icon.snp_right).offset(12)
            make.centerY.equalTo(contentView)
            make.height.equalTo(21)
        }
        line.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
}
