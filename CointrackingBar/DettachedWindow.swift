//
//  DettachedWindow.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DettachedWindow: NSWindow {

    init(popover: NSPopover) {
        super.init(contentRect: NSRect(origin: .zero, size: popover.contentSize),
                   styleMask: [.borderless, .titled, .resizable],
                   backing: .buffered,
                   defer: false)
        appearance = popover.appearance
        let content = popover.contentViewController
        content?.removeFromParentViewController()
        self.contentViewController = content
    }

}
