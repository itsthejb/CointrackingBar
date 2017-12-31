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
        popOver.animates = true
//        let apperance = NSAppearance(appearanceNamed: .vibrantLight, bundle: nil)
//        popOver.appearance = apperance
        popOver.contentViewController = (controller as! NSViewController)
        return popOver
    }()

    func applicationDidFinishLaunching(_ notification: Notification) {
        popOver.delegate = self

        [NSWindow.didResignKeyNotification : #selector(windowDidResignActive(_:))].forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
        NSWorkspace.shared.notificationCenter.addObserver(self,
                                                          selector: #selector(appDidDeactivate(_:)),
                                                          name: NSWorkspace.didActivateApplicationNotification,
                                                          object: nil)
    }

    @objc func menuItemClicked(item: NSStatusItem) {
        togglePopOver()
    }

    private func togglePopOver() {
        popOver.isShown ? hidePopver() : showPopover()
    }

    private func showPopover() {
        guard !popOver.isShown, let button = statusItem.button else { return }
        popOver.show(relativeTo: button.frame, of: button, preferredEdge: .minY)
    }

    private func hidePopver() {
        guard popOver.isShown else { return }
        popOver.performClose(self)
    }

}


extension AppDelegate {

    @objc func windowDidResignActive(_ notification: Notification) {
        togglePopOver()
    }

    @objc func appDidDeactivate(_ notification: Notification) {
        hidePopver()
    }

}


extension AppDelegate: NSPopoverDelegate {
}

