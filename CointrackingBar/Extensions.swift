//
//  NSApperance+Style.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

extension NSAppearance {
    static let style = NSAppearance(named: .vibrantLight)
}

extension NSStatusItem {
    static func statusItem(target: NSObject, action: Selector) -> NSStatusItem {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        item.image = #imageLiteral(resourceName: "btc-black").barItemImage()
        item.action = action
        item.target = target
        return item
    }
}

extension NSImage {
    func barItemImage() -> NSImage {
        let newSize = NSSize(width: 16, height: 16)
        let img = NSImage(size: newSize)

        img.lockFocus()
        let ctx = NSGraphicsContext.current
        ctx?.imageInterpolation = .high
        self.draw(in: NSMakeRect(0, 0, newSize.width, newSize.height),
                  from: NSMakeRect(0, 0, size.width, size.height),
                  operation: .copy,
                  fraction: 1)
        img.unlockFocus()

        return img
    }
}

extension NSButton {

    enum Icon {
        case forwards, backwards, info
    }

    func set(icon: Icon) {
        font = NSFont(name: "FontAwesome5FreeSolid", size: 20)
        title = icon.iconString
    }

    private var iconString: String {
        switch self {
        case .forwards:
            return "\u{f0da}"
        case .backwards:
            return "\u{f0d9}"
        case .info:
            return "\u{f05a}"
        }
    }

}
