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
}

extension WebViewController {

    override func mouseDragged(with theEvent: NSEvent) {
        var currentLocation = NSEvent.mouseLocation
        print("Dragged at : \(currentLocation)")

        /*

        var newOrigin   = currentLocation
        let screenFrame = NSScreen.main?.frame
        var windowFrame = self.view.window?.frame

        newOrigin.x     = screenFrame!.size.width - currentLocation.x
        newOrigin.y     = screenFrame!.size.height - currentLocation.y

        print("the New Origin Points : \(newOrigin)")

        // Don't let window get dragged up under the menu bar
        if newOrigin.x < 450 {
            newOrigin.x = 450
        }

        if newOrigin.y < 650 {
            newOrigin.y = 650
        }

        print("the New Origin Points : \(newOrigin)")

        let appDelegate : AppDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.popOver.contentSize = NSSize(width: newOrigin.x, height: newOrigin.y)
*/
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
