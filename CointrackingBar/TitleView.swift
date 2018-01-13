//
//  TitleView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 13/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class TitleView: NSView {

    var onDrag: ((NSEvent) -> Void)?

}

extension TitleView {

    override func awakeFromNib() {
        super.awakeFromNib()
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .mouseMoved, .activeAlways]
        let trackingArea = NSTrackingArea(rect: bounds,
                                          options: options,
                                          owner: self,
                                          userInfo: nil)
        addTrackingArea(trackingArea)
    }

}

extension TitleView {

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        NSCursor.closedHand.set()
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        NSCursor.openHand.set()
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        onDrag?(event)
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSCursor.openHand.set()
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.arrow.set()
    }

}
