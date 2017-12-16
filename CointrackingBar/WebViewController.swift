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

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://news.bbc.co.uk")!
        let request = URLRequest(url: url)
        webView.load(request)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension WebViewController: WKUIDelegate {

}

extension WebViewController: WKNavigationDelegate {

}
