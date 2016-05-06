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
            if let url = model.user?.profile_image_url {
                logo.sd_setImageWithURL(NSURL(string: url), placeholderImage: nil)
            }
            title.text = model.user?.name
            time.text = model.created_at!.stringWithFormatter("EEE MMM dd HH:mm:ss zzz yyyy")
            source.text = model.source
            contentText.text = model.text
        }
    }
    
    lazy var logo: UIImageView! = {
        let logo = UIImageView()
        logo.layer.cornerRadius = 20
        logo.layer.masksToBounds = true
        return logo
    }()
    
    lazy var title: UILabel! = {
        var title = UILabel()
        title.font = UIFont.systemFontOfSize(16)
        title.textColor = UIColor.orangeColor()
        return title
    }()
    
    lazy var time: UILabel! = {
        var time = UILabel()
        time.font = UIFont.systemFontOfSize(13)
        time.textColor = UIColor.grayColor()
        return time
    }()
    
    lazy var source: UILabel! = {
        var source = UILabel()
        source.font = UIFont.systemFontOfSize(13)
        source.textColor = UIColor.grayColor()
        return source
    }()
    
    lazy var contentText: UILabel! = {
        var contentText = UILabel()
        contentText.numberOfLines = 0
        contentText.font = UIFont.systemFontOfSize(17)
        //iOS7返回高度需要设置
//        contentText.preferredMaxLayoutWidth = KSCREEN_WIDTH - 12*2;
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
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加UI
    private func addUI() {
        contentView.addSubview(logo)
        contentView.addSubview(title)
        contentView.addSubview(time)
        contentView.addSubview(source)
        contentView.addSubview(contentText)
        contentView.addSubview(line)
    }
    
    /// 添加Constraints
    private func addConstraints() {
        logo.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(logo.snp_right).offset(12)
            make.top.equalTo(logo).offset(5)
        }
        time.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(logo.snp_right).offset(12)
            make.bottom.equalTo(logo)
        }
        source.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(time.snp_right).offset(6)
            make.bottom.equalTo(logo)
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
        return contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    }
}
