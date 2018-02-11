//
//  ContentViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 04/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class ContentViewController: NSViewController {

    let webViewController = WebViewController.controller()
    weak var infoViewController: InfoViewController?

    struct Segues {
        static let infoViewController = NSStoryboardSegue.Identifier(class: InfoViewController.self)
    }

    func toggleInfo(animated: Bool) {
        isInfoViewControllerVisible ? hideInfoViewController(animated: animated) : showInfoViewController(animated: animated)
    }

    private func showInfoViewController(animated: Bool) {
        guard infoViewController == nil else { return }
        let controller = InfoViewController.controller()
        defer { infoViewController = controller }
        presentViewController(controller, animator: InfoViewControllerPresentation())
    }

    private func hideInfoViewController(animated: Bool) {
        guard let controller = infoViewController else { return }
        dismissViewController(controller)
    }

    private var isInfoViewControllerVisible: Bool {
        return infoViewController != nil
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        [webViewController]
            .filter { $0.view.superview != nil}
            .forEach { $0.view.frame = view.bounds }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(webViewController)
        view.addSubview(webViewController.view)
    }
    
}

final class InfoViewControllerPresentation: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        guard let from = fromViewController as? ContentViewController else { return }
        from.addChildViewController(viewController)
        from.transition(from: from.webViewController, to: viewController, options: [.slideUp])
    }

    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        guard let from = fromViewController as? ContentViewController else { return }
        from.transition(from: viewController, to: from.webViewController, options: [.crossfade]) {
            viewController.removeFromParentViewController()
        }
    }
}
