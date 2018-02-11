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

    var visibleControllers: [NSViewController] {
        return ([webViewController, infoViewController] as [NSViewController?]).flatMap { $0 }
    }

    weak var delegate: ContentViewControllerDelegate?

    struct Segues {
        static let infoViewController = NSStoryboardSegue.Identifier(class: InfoViewController.self)
    }

    func toggleInfo(animated: Bool) {
        isInfoViewControllerVisible
            ? hideInfoViewController(animated: animated)
            : showInfoViewController(animated: animated)
    }

    private func showInfoViewController(animated: Bool) {
        guard infoViewController == nil else { return }
        presentViewController(InfoViewController.controller(), animator: InfoViewControllerPresentation())
    }

    private func hideInfoViewController(animated: Bool) {
        guard let controller = infoViewController else { return }
        dismissViewController(controller)
    }

    private var isInfoViewControllerVisible: Bool {
        return infoViewController != nil
    }

    override func viewWillLayout() {
        super.viewWillLayout()
        visibleControllers.forEach { $0.view.frame = view.bounds }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(webViewController)
        view.addSubview(webViewController.view)
    }
}

final class InfoViewControllerPresentation: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        guard
            let from = fromViewController as? ContentViewController,
            let to = viewController as? InfoViewController
            else { return }

        from.delegate?.infoViewControllerWillPresent()
        from.addChildViewController(viewController)
        from.transition(from: from.webViewController, to: viewController, options: [.slideUp]) {
            from.infoViewController = to
            from.delegate?.infoViewControllerDidPresent()
        }
    }

    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        guard let from = fromViewController as? ContentViewController else { return }
        from.delegate?.infoViewControllerWillDismiss()
        from.transition(from: viewController, to: from.webViewController, options: [.crossfade]) {
            viewController.removeFromParentViewController()
            from.delegate?.infoViewControllerDidDismiss()
        }
    }
}

protocol ContentViewControllerDelegate: class {
    func infoViewControllerWillPresent()
    func infoViewControllerWillDismiss()
    func infoViewControllerDidPresent()
    func infoViewControllerDidDismiss()
}
