//
//  DetachedWindowController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 23/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DetachedWindowController: NSWindowController, StoryboardViewController {

    init(contentViewController: NSViewController, popover: NSPopover) {
        let rect = NSRect(x: 0, y: 0, width: popover.contentSize.width, height: popover.contentSize.height)
        let window = NSWindow(contentRect: rect,
                              styleMask: [.closable, .titled, .unifiedTitleAndToolbar, .resizable, .borderless],
                              backing: .buffered,
                              defer: false)
        window.appearance = popover.appearance
        super.init(window: window)
        self.contentViewController = contentViewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
