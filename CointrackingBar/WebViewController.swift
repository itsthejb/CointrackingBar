//
//  WebInternal.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 22/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import WebKit

final class WebViewController: NSViewController, StoryboardViewController {

    private let url = URL(string: "https://cointracking.info/dashboard.php?mobile=on")

    @IBOutlet var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView?.isHidden = true
    }

    func load(with delegate: WKUIDelegate & WKNavigationDelegate) {
        loadView()
        guard let webView = webView else { return }
        webView.uiDelegate = delegate
        webView.navigationDelegate = delegate
        representedObject = url
    }

    override func viewDidAppear() {
        super.viewDidAppear()
//        webView?.reload()
    }

    override var representedObject: Any? {
        get { return webView?.url }
        set {
            if let url = newValue as? URL {
                webView?.load(URLRequest(url: url))
            }
        }
    }
    
}

final class WebView: WKWebView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        translatesAutoresizingMaskIntoConstraints = false

        if NSAppKitVersion.current.rawValue > 1500 {
            setValue(false, forKey: "drawsBackground")
        } else {
            setValue(true, forKey: "drawsTransparentBackground")
        }
    }

}
