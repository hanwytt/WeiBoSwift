//
//  WBHomeTableViewCell.swift
//  WeiBoSwift
//
//  Created by 韩伟扬 on 16/4/29.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit

class WBHomeTableViewCell: UITableViewCell {
    
    /// 微博模型
    var model: WBStatusesModel! {
        didSet {
            if let url = model.user.profile_image_url {
                logo.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "avatar_default_small"))
            }
            verifiedLogo.hidden = !model.user.verified
            verifiedLogo.image = model.user.verifiedImage
            title.text = model.user.name
            mbrankLogo.image = model.user.mbrankImage
            time.text = NSDate.statusDateWithStr(model.created_at!)
            source.text = model.sourceText
//            do {
//                try source.attributedText = NSAttributedString(data: (model.source?.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
//            } catch  {
//                print(model.source)
//            }
            contentText.text = model.text
            if model.reposts_count > 0 {
                retweet.setTitle("\(model.reposts_count)", forState: UIControlState.Normal)
            } else {
                retweet.setTitle("转发", forState: UIControlState.Normal)
            }
            if model.comments_count > 0 {
                comment.setTitle("\(model.comments_count)", forState: UIControlState.Normal)
            } else {
                comment.setTitle("评论", forState: UIControlState.Normal)
            }
            if model.attitudes_count > 0 {
                like.setTitle("\(model.attitudes_count)", forState: UIControlState.Normal)
            } else {
                like.setTitle("赞", forState: UIControlState.Normal)
            }
            if model.favorited {
                like.setImage(UIImage(named: "timeline_icon_like"), forState: UIControlState.Normal)
            } else {
                like.setImage(UIImage(named: "timeline_icon_unlike"), forState: UIControlState.Normal)
            }
        }
    }
    
    /// 头像
    lazy var logo: UIImageView! = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    /// 认证图标
    lazy var verifiedLogo: UIImageView! = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 标题
    lazy var title: UILabel! = {
        var lable = UILabel()
        lable.font = UIFont.systemFontOfSize(16)
        lable.textColor = UIColor.orangeColor()
        return lable
    }()
    
    /// 认证图标
    lazy var mbrankLogo: UIImageView! = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 时间
    lazy var time: UILabel! = {
        var lable = UILabel()
        lable.font = UIFont.systemFontOfSize(13)
        lable.textColor = UIColor.grayColor()
        return lable
    }()
    
    /// 来源
    lazy var source: UILabel! = {
        var lable = UILabel()
        lable.font = UIFont.systemFontOfSize(13)
        lable.textColor = UIColor.grayColor()
        return lable
    }()
    
    /// 内容
    lazy var contentText: UILabel! = {
        var lable = UILabel()
        lable.numberOfLines = 0
        lable.font = UIFont.systemFontOfSize(17)
        //iOS7返回高度需要设置
//        lable.preferredMaxLayoutWidth = KSCREEN_WIDTH - 12*2;
        return lable
    }()
    
    /// 底部view
    lazy var bottomView: UIView! = {
        var view = UIView()
        return view
    }()
    
    /// 横线条1
    lazy var line1: UIView! = {
        var view = UIView()
        view.backgroundColor = DefaultLineRGB
        return view
    }()
    
    /// 横线条2
    lazy var line2: UIView! = {
        var view = UIView()
        view.backgroundColor = DefaultLineRGB
        return view
    }()
    
    /// 竖线条2
    lazy var line3: UIView! = {
        var view = UIView()
        view.backgroundColor = DefaultLineRGB
        return view
    }()
    
    /// 竖线条2
    lazy var line4: UIView! = {
        var view = UIView()
        view.backgroundColor = DefaultLineRGB
        return view
    }()
    
    /// 转发
    lazy var retweet: UIButton! = {
        return UIButton.createStatusCellButton("转发", imageName: "timeline_icon_retweet", target: self, action: Selector("retweetClick:"))
    }()
    
    /// 评论
    lazy var comment: UIButton! = {
        return UIButton.createStatusCellButton("评论", imageName: "timeline_icon_comment", target: self, action: Selector("commentClick:"))
    }()

    /// 点赞
    lazy var like: UIButton! = {
        return UIButton.createStatusCellButton("赞", imageName: "timeline_icon_unlike", target: self, action: Selector("likeClick:"))
    }()
    
    func createButton(title:String, imageName:String, target: AnyObject?, action: Selector) -> UIButton {
        let button = UIButton(type: UIButtonType.Custom)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
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
        contentView.addSubview(verifiedLogo)
        contentView.addSubview(title)
        contentView.addSubview(mbrankLogo)
        contentView.addSubview(time)
        contentView.addSubview(source)
        contentView.addSubview(contentText)
        contentView.addSubview(bottomView)
        bottomView.addSubview(retweet)
        bottomView.addSubview(comment)
        bottomView.addSubview(like)
        bottomView.addSubview(line1)
        bottomView.addSubview(line2)
        bottomView.addSubview(line3)
        bottomView.addSubview(line4)
    }
    
    /// 添加Constraints
    private func addConstraints() {
        logo.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        verifiedLogo.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(logo)
            make.width.height.equalTo(14)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(logo.snp_right).offset(12)
            make.top.equalTo(logo).offset(5)
        }
        mbrankLogo.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(title)
            make.left.equalTo(title.snp_right).offset(5)
            make.width.height.equalTo(14)
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
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentText.snp_bottom).offset(20)
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(34)
        }
        retweet.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(0)
        }
        comment.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweet.snp_right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(retweet)
        }
        like.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(comment.snp_right)
            make.top.bottom.right.equalTo(0)
            make.width.equalTo(comment)
        }
        line1.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(0)
            make.height.equalTo(1)
        }
        line2.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        line3.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(comment).offset(-0.5)
            make.centerY.equalTo(0)
            make.height.equalTo(20)
            make.width.equalTo(1)
        }
        line4.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(comment).offset(0.5)
            make.centerY.equalTo(0)
            make.height.equalTo(20)
            make.width.equalTo(1)
        }
    }
    
    func retweetClick(sender:UIButton) {
        print("retweetClick")
    }
    
    func commentClick(sender:UIButton) {
        print("commentClick")
    }
    
    func likeClick(sender:UIButton) {
        model.favorited = !model.favorited
        if model.favorited {
            model.attitudes_count += 1
        } else {
            model.attitudes_count -= 1
        }
    }
    
    //iOS7需要
//    func rowHeight(model: WBStatusesModel) -> CGFloat {
//        self.model = model
//        return contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
//    }
}
