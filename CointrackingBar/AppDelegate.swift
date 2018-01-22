//
//  AppDelegate.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    let popover = Popover()

}

extension AppDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusItem.statusItem(target: self,
                                             action: #selector(menuItemClicked(item:)))
    }

}

extension AppDelegate {

    @objc func menuItemClicked(item: NSStatusItem) {
        togglePopOver()
    }

    private func togglePopOver() {
        popover.isShown ? hidePopver() : showPopover()
    }

    private func showPopover() {
        guard !popover.isShown, let button = statusItem?.button else { return }
        popover.show(relativeTo: button.frame, of: button, preferredEdge: .minY)
    }

    private func hidePopver() {
        guard popover.isShown else { return }
        popover.performClose(self)
    }

}

