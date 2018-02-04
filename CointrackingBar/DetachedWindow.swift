//
//  DetachedWindowController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 23/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DetachedWindowController: NSWindowController, StoryboardViewController {
    func set(contentViewController: NSViewController, popover: NSPopover) {
        guard let window = window else { return }
        self.contentViewController = contentViewController
        window.appearance = popover.appearance
    }
}
