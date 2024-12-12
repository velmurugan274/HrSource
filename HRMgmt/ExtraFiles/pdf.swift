//
//  pdf.swift
//  HRMgmt
//
//  Created by vel-pt2332 on 04/06/19.
//  Copyright © 2019 vel-pt2332. All rights reserved.
//

//import UIKit
//import WebKit
//
//class PdfView: UIViewController, WKNavigationDelegate {
//
//    var webView = WKWebView()
//
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let url: URL! = URL(string: "https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf")
//        webView.load(URLRequest(url: url))
//        view.backgroundColor = UIColor(red: 231.0/255.0, green: 243/255.0, blue:253/255.0, alpha: 1)
//      //  view.addSubview(we)
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(webView.reload))
//
//        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
//
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        title = webView.title
//    }
//}

import UIKit
import WebKit

class PdfView: UIViewController, WKNavigationDelegate {
    let webview = WKWebView()
    override func viewDidLoad() {
        
       // webview.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        webview.load(URLRequest(url: URL(string: "https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf")!) as URLRequest)
        view.backgroundColor = .white
        self.view.addSubview(webview)
       // self.view.addSubview(webview)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
        webview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        webview.backgroundColor = .clear
        navigationItem.title = "Leave Policy"
    }
    @objc func reload(){
        webview.reload()
    }
    

}
