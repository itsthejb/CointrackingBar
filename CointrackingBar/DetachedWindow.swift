//
//  DetachedWindowController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 23/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DetachedWindowController: NSWindowController {

//    static var controller: DetachedWindowController {
//        
//    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}

final class DettachedWindow: NSWindow {

    init(popover: NSPopover) {
        super.init(contentRect: NSRect(origin: .zero, size: popover.contentSize),
                   styleMask: [.borderless, .titled, .resizable, .closable],
                   backing: .buffered,
                   defer: false)
        appearance = popover.appearance
        let content = popover.contentViewController
        content?.removeFromParentViewController()
        self.contentViewController = content
    }

    deinit {
        return
    }

}
