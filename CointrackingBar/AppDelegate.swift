//
//  AppDelegate.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem: NSStatusItem = {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        item.action = #selector(menuItemClicked(item:))
        item.image = #imageLiteral(resourceName: "switchIcon")
        return item
    }()

    var popOver: NSPopover?

    @objc func menuItemClicked(item: NSStatusItem) {
        if let popOver = popOver {
            popOver.close()
            self.popOver = nil
        } else {
            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
            let controller = storyboard.instantiateInitialController() as! WebViewController
            let popOver = NSPopover()
            popOver.delegate = self
            popOver.animates = true
            popOver.contentViewController = controller
            self.popOver = popOver
        }
    }


}

extension AppDelegate: NSPopoverDelegate {

    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        return true
    }

    func popoverDidClose(_ notification: Notification) {
        popOver = nil
    }

}

