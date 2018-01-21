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
    private weak var popOver: NSPopover?

    @IBOutlet weak var titleView: TitleView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView?.isHidden = false
//        let url = URL(string: "https://cointracking.info/dashboard.php?mobile=on")!
//        webView.load(URLRequest(url: url))

        backButton.set(icon: .backwards)
        forwardButton.set(icon: .forwards)

        titleView.onDrag = { [unowned self] event in
            guard let popOver = self.popOver else { return }
            let transform = CGAffineTransform(translationX: event.deltaX, y: event.deltaY)
            let rect = popOver.positioningRect.applying(transform)
            popOver.show(relativeTo: rect, of: self.view, preferredEdge: .minX)
            print(popOver.positioningRect)
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
        guard let popOver = notification.object as? NSPopover else { return }
        self.popOver = popOver
    }

    func detachableWindow(for popover: NSPopover) -> NSWindow? {
        return DettachedWindow(size: popover.contentSize)
    }

    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }

}

//extension WebViewController {
//
//    override func mouseDragged(with theEvent: NSEvent) {
//        super.mouseDragged(with: theEvent)
//
//        guard
//            let popOver = popOver,
//            let window = theEvent.window,
//            theEvent.window == view.window
//            else { return }
//
//        let location = self.view.convert(theEvent.locationInWindow, from: nil)
//        popOver.positioningRect.origin.x = location.x
//        popOver.positioningRect.origin.y = location.y
//
//        return
//
//        var frame = view.frame
//        frame.applying(CGAffineTransform(translationX: theEvent.deltaX, y: theEvent.deltaY))
//        popOver.show(relativeTo: frame, of: view, preferredEdge: .minX)
///*
//        let location = theEvent.locationInWindow
//        print("popover: \(view.frame)")
//        print("Dragged at : \(location)")
//
//        var frame = view.frame
////        frame.width -= location.x
////        frame.height -= location.y
//
//        popOver.contentSize = NSSize(width: popOver.contentSize.width - location.x / 4,
//                                     height: popOver.contentSize.height - location.y / 4)
//*/
//        /*
//
//        var newOrigin   = currentLocation
//        let screenFrame = NSScreen.main?.frame
//        var windowFrame = self.view.window?.frame
//
//        newOrigin.x     = screenFrame!.size.width - currentLocation.x
//        newOrigin.y     = screenFrame!.size.height - currentLocation.y
//
//        print("the New Origin Points : \(newOrigin)")
//
//        // Don't let window get dragged up under the menu bar
//        if newOrigin.x < 450 {
//            newOrigin.x = 450
//        }
//
//        if newOrigin.y < 650 {
//            newOrigin.y = 650
//        }
//
//        print("the New Origin Points : \(newOrigin)")
//
//        let appDelegate : AppDelegate = NSApplication.shared.delegate as! AppDelegate
//        appDelegate.popOver.contentSize = NSSize(width: newOrigin.x, height: newOrigin.y)
//*/
//    }
//
//}

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
