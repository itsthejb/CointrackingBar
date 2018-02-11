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
//    let infoViewController = InfoViewController.controller()

//    enum Content {
//        case webView, info
//    }

    struct Segues {
        static let infoViewController = NSStoryboardSegue.Identifier(class: InfoViewController.self)
    }

    func toggleInfo(animated: Bool) {
        isInfoViewControllerVisible ? hideInfoViewController(animated: animated) : showInfoViewController(animated: animated)
    }

    private func showInfoViewController(animated: Bool) {
        performSegue(withIdentifier: Segues.infoViewController, sender: self)
//        addChildViewController(infoViewController)
//        transition(from: webViewController, to: infoViewController, options: .slideUp)
    }

    private func hideInfoViewController(animated: Bool) {
//        transition(from: infoViewController, to: webViewController, options: .slideDown) {
//            self.infoViewController.removeFromParentViewController()
//        }
    }

    private var isInfoViewControllerVisible: Bool {
        return false
//        return infoViewController.view.superview != nil
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
