//
//  AppDelegate.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa
import Fabric
import Crashlytics

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    weak var dettachedWindow: NSWindow?
    let popover = Popover()

    override init() {
        super.init()
        UserDefaults.standard.register(defaults: [
            "NSApplicationCrashOnExceptions": true
            ])
        Fabric.with([Crashlytics.self, Answers.self]).debug = true
    }
}

extension AppDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        updateBarIcon(UserDefaults.standard.barIcon)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(barIconPreferenceDidChange(_:)),
                                               name: BarIcon.barIconPreferenceDidChange,
                                               object: nil)
    }

    @objc private func barIconPreferenceDidChange(_ notification: Notification) {
        guard let icon = notification.object as? BarIcon else { return }
        updateBarIcon(icon)
    }

    private func updateBarIcon(_ icon: BarIcon?) {
        guard let icon = icon else { return }
        statusItem = NSStatusItem.statusItem(
            icon: icon,
            target: self,
            action: #selector(menuItemClicked(item:)))
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

