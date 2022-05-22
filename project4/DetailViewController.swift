//
//  DetailViewController.swift
//  project4
//
//  Created by Denys Denysenko on 13.10.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var selectedLink : String?
    
    var webView : WKWebView!
    
    var progressView : UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + selectedLink!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: webView, action: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton  = UIBarButtonItem(customView: progressView)
        
        
        toolbarItems = [ progressButton, spacer, back, forward, refresh]
        navigationController?.isToolbarHidden  = false
        

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
       
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
   
}
