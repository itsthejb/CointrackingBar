//
//  ViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa
import WebKit

final class MainViewController: NSViewController, StoryboardViewController {

    weak var webView: WKWebView? { return webViewController?.webView }
    weak var webViewController: WebViewController? { return contentViewController?.webViewController }

    weak var contentViewController: ContentViewController? {
        didSet {
            contentViewController?.delegate = self
            guard let controller = webViewController else { return }
            controller.load(with: self)
        }
    }

    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    @IBOutlet weak var infoButton: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    var controlButtons: [NSButton] { return [backButton, forwardButton] }

    @IBOutlet weak var loadingView: LoadingView!
    private weak var popover: NSPopover?

    func detachedWindowController(contentController: NSViewController, popover: NSPopover) -> DetachedWindowController {
        return DetachedWindowController(contentViewController: contentController, popover: popover)
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
        case let controller as ContentViewController:
            contentViewController = controller
        default:
            break
        }
    }
    
}

extension MainViewController: ContentViewControllerDelegate {
    
    func infoViewControllerWillPresent() {
        NSAnimationContext.runAnimationGroup({ _ in
            controlButtons.forEach { $0.isHidden = true }
        }, completionHandler: nil)
    }

    func infoViewControllerDidDismiss() {
        NSAnimationContext.runAnimationGroup({ _ in
            controlButtons.forEach { $0.isHidden = false }
        }, completionHandler: nil)
    }

    func infoViewControllerWillDismiss() {}
    func infoViewControllerDidPresent() {}

}

extension MainViewController {

    @IBAction func infoButtonPressed(_ sender: NSButton) {
        contentViewController?.toggleInfo(animated: true)
    }

}

extension MainViewController: NSPopoverDelegate {

    func popoverWillShow(_ notification: Notification) {
        guard let popover = notification.object as? NSPopover else { return }
        self.popover = popover
    }

    func detachableWindow(for popover: NSPopover) -> NSWindow? {
        return detachedWindowController(contentController: self, popover: popover).window
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
