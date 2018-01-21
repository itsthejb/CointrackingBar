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
