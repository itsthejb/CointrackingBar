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

    enum Content {
        case webView, info
    }

    func toggleInfo(animated: Bool) {
        isInfoViewControllerVisible ? hideInfoViewController(animated: animated) : showInfoViewController(animated: animated)
    }

    private func showInfoViewController(animated: Bool) {
        let infoViewController = InfoViewController.controller()
        addChildViewController(infoViewController)
        transition(from: webViewController, to: infoViewController, options: .slideUp) {
//            controller.removeFromParentViewController()
        }
    }

    private func hideInfoViewController(animated: Bool) {
        guard let infoController = infoViewController else { return }
        transition(from: infoController, to: webViewController, options: .slideUp) {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(webViewController)
        view.addSubview(webViewController.view)
        NSLayoutConstraint.activate([
            webViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            webViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            webViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
}
