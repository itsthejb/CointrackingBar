//
//  ViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa
import WebKit

final class WebViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressContainer: NSView!
    @IBOutlet weak var progressView: NSProgressIndicator!
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    @IBOutlet weak var loadingView: LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView?.isHidden = false
        let url = URL(string: "https://cointracking.info/dashboard.php?mobile=on")!
        webView.load(URLRequest(url: url))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func backButtonPressed(_ sender: NSButton) {
        webView.goBack()
    }

    @IBAction func forwardButtonPressed(_ sender: NSButton) {
        webView.goForward()
    }

    @IBAction func quitButtonPressed(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
}

extension WebViewController: WKUIDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        progressContainer.isHidden = false
        progressView.startAnimation(self)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressContainer.isHidden = true
        progressView.startAnimation(self)
        loadingView?.removeFromSuperview()
    }

}

extension WebViewController: WKNavigationDelegate {

}
