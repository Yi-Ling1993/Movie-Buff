//
//  WebviewViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/2.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController, WKNavigationDelegate {
    
    var webDetail: TheaterInfo?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        title = webDetail?.name

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = URL(string: webDetail?.website ?? "https://www.apple.com") {
            
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        nextButton.isEnabled = webView.canGoForward
    }
    

}
