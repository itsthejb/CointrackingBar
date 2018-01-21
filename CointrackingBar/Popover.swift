//
//  Popover.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class Popover: NSPopover {

    override init() {
        super.init()
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = String(describing: WebViewController.self)
        let scene = NSStoryboard.SceneIdentifier(identifier)
        let controller = storyboard.instantiateController(withIdentifier: scene) as! WebViewController
        appearance = NSAppearance(named: .vibrantDark)
        contentViewController = controller
        animates = true
        behavior = .transient
        delegate = controller
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
