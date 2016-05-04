//
//  WBHomeTableViewCell.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/29.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBHomeTableViewCell: UITableViewCell {
    
    var model: WBStatusesModel! {
        didSet {
            contentText.text = model.text
        }
    }
    
    lazy var logo: UIImageView! = {
        let logo = UIImageView()
        logo.layer.cornerRadius = 20
        logo.layer.masksToBounds = true
        logo.backgroundColor = UIColor.redColor()
        return logo
    }()
    
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
        backgroundColor = UIColor.whiteColor()
        addUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加UI
    private func addUI() {
        contentView.addSubview(logo)
        contentView.addSubview(contentText)
        contentView.addSubview(line)
        logo.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        contentText.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(logo)
            make.right.equalTo(-12)
            make.top.equalTo(logo.snp_bottom).offset(12)
        }
        line.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentText.snp_bottom).offset(10)
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    func rowHeight(model: WBStatusesModel) -> CGFloat {
        self.model = model
        layoutIfNeeded()
//        setNeedsUpdateConstraints()
//        updateConstraintsIfNeeded()
        return CGRectGetMaxY(line.frame)
    }
}
