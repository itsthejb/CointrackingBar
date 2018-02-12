//
//  WebInternal.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 22/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import WebKit

final class WebViewController: NSViewController {

    private let url = URL(string: "https://cointracking.info/dashboard.php?mobile=on")
    @IBOutlet var webView: WKWebView?

    static func controller(storyboardNamed name: String = "") -> WebViewController {
        return WebViewController()
    }

    override func loadView() {
        guard !isViewLoaded else { return }
        (self.view, self.webView) = {
            let webView = WebView()
            return (webView, webView)
        }()
    }

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
    init() {
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        if NSAppKitVersion.current.rawValue > 1500 {
            setValue(false, forKey: "drawsBackground")
        } else {
            setValue(true, forKey: "drawsTransparentBackground")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
