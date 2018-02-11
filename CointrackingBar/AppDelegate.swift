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
    weak var dettachedWindow: NSWindow?
    let popover = Popover()
}

extension AppDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        UserDefaults.standard.set(false, forKey: "NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints")
        statusItem = NSStatusItem.statusItem(target: self,
                                             action: #selector(menuItemClicked(item:)))
        windowNotifications.forEach {
                NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }

    private var windowNotifications: [Notification.Name: Selector] {
        return [
            NSWindow.didBecomeMainNotification: #selector(windowDidBecomeMainNotification(_:))
        ]
    }

    @objc private func windowDidBecomeMainNotification(_ notification: Notification) {
        guard let window = notification.object as? NSWindow else { return }
        dettachedWindow = window
    }
}

extension AppDelegate {
    @objc func menuItemClicked(item: NSStatusItem) {
        togglePopOver()
    }

    private func togglePopOver() {
        switch (popover.isShown, dettachedWindow) {
        case (true, .none):
            hidePopver()
        case (false, .none):
            showPopover()
        case (false, .some(let window)):
            window.close()
        default:
            fatalError("Popover state")
        }
    }

    private var isPopoverShown: Bool {
        return popover.isShown
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

