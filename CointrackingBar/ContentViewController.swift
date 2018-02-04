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
//        guard let webController = webViewController else { return }
//        let controller = NSStoryboard.with(class: InfoViewController.self)
//        insertChildViewController(controller, at: 0)
//        transition(from: webController, to: controller)
    }

    private func hideInfoViewController(animated: Bool) {
//        guard let webController = webViewController, let infoController = infoViewController else { return }
//        transition(from: infoController, to: webController, options: .crossfade) {
//            infoController.removeFromParentViewController()
//        }
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
//        hideInfoViewController()
        webViewController.view.translatesAutoresizingMaskIntoConstraints = false
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
