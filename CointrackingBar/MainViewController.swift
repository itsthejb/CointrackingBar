//
//  ViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa
import WebKit

final class MainViewController: NSViewController {

    private let url = URL(string: "https://cointracking.info/dashboard.php?mobile=on")

    weak var webView: WKWebView? { return webViewController?.webView }
    weak var webViewController: WebViewController? {
        didSet {
            guard let controller = webViewController else { return }
            controller.loadView()
            guard let webView = webView else { return }
            webView.uiDelegate = self
            webView.navigationDelegate = self
            controller.representedObject = url
        }
    }

    @IBOutlet weak var loadingView: LoadingView!

    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    @IBOutlet weak var infoButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!

    private weak var popover: NSPopover?

    lazy var detachedWindowController: DetachedWindowController = {
        let controller = NSStoryboard.with(class: DetachedWindowController.self)
//        let detachedWindowController = DetachedWindowController(windowNibName: NSNib.Name(rawValue: ""))
//        detachedWindowController.contentViewController = ContentViewController()

//        self.detachedWindowControllerLoaded = true
//        NotificationCenter.default.addObserver(self, selector: #selector(detachedWindowWillClose(notification:)), name: NSWindow.willCloseNotification, object: detachedWindowController.window)

        return controller
    }()
    //private var dettachedWindow: NSWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.set(icon: .backwards)
        forwardButton.set(icon: .forwards)
        infoButton.set(icon: .info)
    }

    @IBAction func backButtonPressed(_ sender: NSButton) {
        webView?.goBack()
    }

    @IBAction func forwardButtonPressed(_ sender: NSButton) {
        webView?.goForward()
    }

    @IBAction func quitButtonPressed(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }

    @IBAction func infoButtonPressed(_ sender: NSButton) {
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.destinationController {
        case let web as WebViewController:
            webViewController = web
        default:
            break
        }
    }
    
}

extension MainViewController: NSPopoverDelegate {

    func popoverWillShow(_ notification: Notification) {
        guard let popover = notification.object as? NSPopover else { return }
        self.popover = popover
    }

    func detachableWindow(for popover: NSPopover) -> NSWindow? {
        let dettachedWindow = DettachedWindow(popover: popover)
//        defer {  }
        dettachedWindow.delegate = self
//        self.dettachedWindow = dettachedWindow
        return dettachedWindow
    }

    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }

}

extension MainViewController: NSWindowDelegate {

    func windowWillClose(_ notification: Notification) {
        guard let window = notification.object as? DettachedWindow else { return }
        popover?.contentViewController = window.contentViewController
//        guard notification.object as? NSWindow == dettachedWindow else { return }
//
////        dettachedWindow = nil
    }

}

extension MainViewController: WKUIDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingView.startLoading()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopLoading()
        backButton.isEnabled = webView.backForwardList.backItem != nil
        forwardButton.isEnabled = webView.backForwardList.forwardItem != nil

        guard webView.isHidden else { return }
        webView.animator().isHidden = false
    }

}

extension MainViewController: WKNavigationDelegate {

}
