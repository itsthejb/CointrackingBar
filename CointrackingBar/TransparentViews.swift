//
//  TransparentView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class TransparentView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.clear.set()
        NSRect.fill(dirtyRect)(using: .copy)
    }
    
}

final class TransparentStackView: NSStackView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.clear.set()
        NSRect.fill(dirtyRect)(using: .copy)
    }

}
