//
//  WBAuthorizeViewController.swift
//  WeiBoSwift
//
//  Created by hanwy on 16/4/24.
//  Copyright © 2016年 hanwy. All rights reserved.
//

import UIKit
import Alamofire

class WBAuthorizeViewController: UIViewController {
    let App_Key = "1034257092"
    let App_Secret = "810f1a0c0125ee4497f6b37171536d07"
    let redirect_uri = "https://www.baidu.com"
    
    lazy var webView: UIWebView = {
        var web = UIWebView()
        web.delegate = self
        return web
    }()
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(App_Key)&response_type=code&redirect_uri=\(redirect_uri)"
        if let url = NSURL.init(string: urlStr) {
            let request = NSURLRequest.init(URL: url)
            webView.loadRequest(request)
        }
    }
}

extension WBAuthorizeViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.URL!.absoluteString.hasPrefix(redirect_uri) {
            let prefix = "code="
            if request.URL!.query!.hasPrefix(prefix) {
                print("授权")
                let code = request.URL!.query!.substringFromIndex(prefix.endIndex)
                loadAccessToken(code)
                
            } else {
                print("取消")
            }
            return false
        }
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    
    private func loadAccessToken(code: String)
    {
        let path = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id":App_Key, "client_secret":App_Secret, "grant_type":"authorization_code", "code":code, "redirect_uri":redirect_uri]
        Alamofire.request(.POST, path, parameters: parameters)
            .responseJSON { (_, _, result) in
                if let json = result.value {
                    print(json)
                    let model = WBAuthorizeModel(dict: json as! [String : AnyObject])
                    if model.error == nil {
                        model.saveAuthorize()
                        AppDelegate.shareAppDelegate().loginSucceses()
                    }
                } else {
                    print(result.error)
                }
            }
    }
}
