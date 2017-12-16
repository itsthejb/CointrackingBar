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

    let popOver: NSPopover = {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("WebViewController"))
        let popOver = NSPopover()
        let apperance = NSAppearance(appearanceNamed: .vibrantLight, bundle: nil)
        popOver.animates = true
        popOver.appearance = apperance
//        popOver.contentSize = CGSize(width: 480, height: 480 * 1.618)
        popOver.contentViewController = (controller as! NSViewController)
        return popOver
    }()

    func applicationDidFinishLaunching(_ notification: Notification) {
        popOver.delegate = self
    }

    @objc func menuItemClicked(item: NSStatusItem) {
        guard let button = statusItem.button else { return }

        if popOver.isShown {
            popOver.performClose(self)
        } else {
            popOver.show(relativeTo: button.frame, of: button, preferredEdge: .minY)
        }
    }


}

extension AppDelegate: NSPopoverDelegate {

//    func popoverShouldClose(_ popover: NSPopover) -> Bool {
//        return true
//    }
//
//    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
//        return true
//    }
//
//    func popoverDidClose(_ notification: Notification) {
////        popOver = nil
//    }

}

