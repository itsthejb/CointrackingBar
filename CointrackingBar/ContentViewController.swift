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
        presentViewController(<#T##viewController: NSViewController##NSViewController#>, animator: <#T##NSViewControllerPresentationAnimator#>)
        performSegue(withIdentifier: Segues.infoViewController, sender: self)
    }

    private func hideInfoViewController(animated: Bool) {
        guard let controller = infoViewController else { return }
        dismissViewController(controller)
//        infoViewController?.dismissViewController(<#T##viewController: NSViewController##NSViewController#>)
//        transition(from: infoViewController, to: webViewController, options: .slideDown) {
//            self.infoViewController.removeFromParentViewController()
//        }
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

extension ContentViewController {

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.destinationController {
        case let controller as InfoViewController:
            infoViewController = controller
        default:
            break
        }
    }

}


final class InfoViewControllerSegue: NSStoryboardSegue {

    override func perform() {
        guard
            let source = sourceController as? ContentViewController,
            let destination = destinationController as? NSViewController
            else { return }
        source.addChildViewController(destination)
        source.transition(from: source.webViewController,
                          to: destination, options: [.slideUp],
                          completionHandler: nil)
    }

}
