//
//  TransparentView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

extension NSView {
    func drawTransparentFill(_ dirtyRect: NSRect) {
        NSColor.clear.set()
        NSRect.fill(dirtyRect)(using: .copy)
    }
}

class TransparentView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawTransparentFill(dirtyRect)
    }
}

final class TransparentStackView: NSStackView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawTransparentFill(dirtyRect)
    }
}
