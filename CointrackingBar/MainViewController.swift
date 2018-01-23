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
    @IBOutlet weak var contentContainer: NSView!

    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    @IBOutlet weak var infoButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!

    private weak var popover: NSPopover?

    func detachedWindowController(contentController: NSViewController) -> DetachedWindowController {
        let controller = NSStoryboard.with(class: DetachedWindowController.self)
        controller.contentViewController = contentController
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(detachedWindowWillClose(_:)),
                                               name: NSWindow.willCloseNotification,
                                               object: controller.window)
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.set(icon: .backwards)
        forwardButton.set(icon: .forwards)
        infoButton.set(icon: .info)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
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

extension MainViewController {

    @IBAction func infoButtonPressed(_ sender: NSButton) {
        isInfoViewControllerVisible ? hideInfoViewController() : showInfoViewController()
    }

    private func showInfoViewController() {
        guard let webController = webViewController else { return }
        let controller = NSStoryboard.with(class: InfoViewController.self)
        insertChildViewController(controller, at: 0)
        transition(from: webController, to: controller)
    }

    private func hideInfoViewController() {
        guard let webController = webViewController, let infoController = infoViewController else { return }
        transition(from: infoController, to: webController, options: .crossfade) {
            infoController.removeFromParentViewController()
        }
    }

    private var infoViewController: InfoViewController? {
        let controllers = childViewControllers.flatMap { $0 as? InfoViewController }
        assert(controllers.count <= 1, "More than 1 info controller \(controllers)")
        return controllers.first
    }

    private var isInfoViewControllerVisible: Bool {
        return infoViewController != nil
    }

}

extension MainViewController: NSPopoverDelegate {

    func popoverWillShow(_ notification: Notification) {
        guard let popover = notification.object as? NSPopover else { return }
        self.popover = popover
    }

    func detachableWindow(for popover: NSPopover) -> NSWindow? {
        return detachedWindowController(contentController: self).window
    }

    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }

}

extension MainViewController: NSWindowDelegate {

    @objc func detachedWindowWillClose(_ notification: Notification) {
        // TODO pass back?
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
