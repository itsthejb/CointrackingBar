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
        let identifier = String(describing: WebViewController.self)
        let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(identifier)) as! WebViewController
        let popOver = NSPopover()
        popOver.animates = true
        popOver.behavior = .transient
//        let apperance = NSAppearance(appearanceNamed: .vibrantLight, bundle: nil)
//        popOver.appearance = apperance
        popOver.contentViewController = controller
        popOver.delegate = controller
        return popOver
    }()

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

