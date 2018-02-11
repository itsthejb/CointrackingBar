//
//  InfoViewControllerSegue.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 11/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class InfoViewControllerSegue: NSStoryboardSegue {

    override func perform() {
        guard
            let source = sourceController as? ContentViewController,
            let destination = destinationController as? NSViewController
            else { return }
        source.addChildViewController(destination)
        source.transition(from: source.webViewController, to: destination, options: [], completionHandler: nil)
    }

}
