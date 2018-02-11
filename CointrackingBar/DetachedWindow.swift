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
                              styleMask: [.closable, .resizable, .borderless, .titled],
                              backing: .buffered,
                              defer: false)
        super.init(window: window)
        self.contentViewController = contentViewController
        window.appearance = popover.appearance
//        window.delegate = self
//        print(window)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DetachedWindowController: NSWindowDelegate {

    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        contentViewController?.view.frame = NSRect(origin: .zero, size: frameSize)
        return frameSize
    }

}
