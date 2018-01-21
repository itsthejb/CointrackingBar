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
    private weak var popover: NSPopover?

    @IBOutlet weak var titleView: TitleView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView?.isHidden = false
        let url = URL(string: "https://cointracking.info/dashboard.php?mobile=on")!
        webView.load(URLRequest(url: url))

        backButton.set(icon: .backwards)
        forwardButton.set(icon: .forwards)

        titleView.onDrag = { [unowned self] event in
            guard let popover = self.popover else { return }
            let transform = CGAffineTransform(translationX: event.deltaX, y: event.deltaY)
            let rect = popover.positioningRect.applying(transform)
            popover.show(relativeTo: rect, of: self.view, preferredEdge: .minX)
            print(popover.positioningRect)
//            print(event.deltaY)
        }
//        view.addTrackingArea(titleView.trackingArea)
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
        progressContainer.isHidden = false
        progressView.startAnimation(self)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressContainer.isHidden = true
        progressView.startAnimation(self)
        loadingView?.removeFromSuperview()
        backButton.isEnabled = webView.backForwardList.backItem != nil
        forwardButton.isEnabled = webView.backForwardList.forwardItem != nil
    }

}

extension WebViewController: WKNavigationDelegate {

}
