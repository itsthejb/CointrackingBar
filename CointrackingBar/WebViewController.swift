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
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    private weak var popover: NSPopover?
    @IBOutlet weak var loadingView: LoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        representedObject = URL(string: "https://cointracking.info/dashboard.php?mobile=on")
        webView.isHidden = true

        backButton.set(icon: .backwards)
        forwardButton.set(icon: .forwards)
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        webView.reload()
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

    override var representedObject: Any? {
        get {
            return webView.url
        }
        set {
            if let url = newValue as? URL {
                webView.load(URLRequest(url: url))
            }
        }
    }
}

extension WebViewController: NSPopoverDelegate {

    func popoverWillShow(_ notification: Notification) {
        guard let popover = notification.object as? NSPopover else { return }
        self.popover = popover
    }

    func detachableWindow(for popover: NSPopover) -> NSWindow? {
        return DettachedWindow(popover: popover)
    }

    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }

}

extension WebViewController: WKUIDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingView.startLoading()
//        progressContainer.isHidden = false
//        progressView.startAnimation(self)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopLoading()
//        progressContainer.isHidden = true
//        progressView.startAnimation(self)
//        loadingView?.removeFromSuperview()

        backButton.isEnabled = webView.backForwardList.backItem != nil
        forwardButton.isEnabled = webView.backForwardList.forwardItem != nil

        guard webView.isHidden else { return }
        webView.animator().isHidden = false
    }

}

extension WebViewController: WKNavigationDelegate {

}
