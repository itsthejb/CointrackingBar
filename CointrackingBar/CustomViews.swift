//
//  DettachedWindow.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class Popover: NSPopover {

    private let contentWidth: CGFloat = 466

    override init() {
        super.init()
        appearance = NSAppearance.style
        contentSize = NSSize(width: contentWidth, height: contentWidth * 1.61803398875)
        animates = true
        behavior = .semitransient
    }

    override func show(relativeTo positioningRect: NSRect, of positioningView: NSView, preferredEdge: NSRectEdge) {
        let controller = MainViewController.controller()
        contentViewController = controller
        delegate = controller
        super.show(relativeTo: positioningRect, of: positioningView, preferredEdge: preferredEdge)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSView {
    func fillColorBackground(_ color: NSColor, dirtyRect: NSRect) {
        color.set()
        NSRect.fill(dirtyRect)(using: .copy)
    }
}

class BackgroundColorView: NSView {
    fileprivate var backgroundColor: NSColor?

    init(color: NSColor) {
        self.backgroundColor = color
        super.init(frame: .zero)
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let color = backgroundColor ?? .white
        fillColorBackground(color, dirtyRect: dirtyRect)
    }
}

class TransparentView: BackgroundColorView {
    init() {
        super.init(color: .clear)
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.backgroundColor = .clear
    }
}

final class TransparentStackView: NSStackView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        fillColorBackground(.clear, dirtyRect: dirtyRect)
    }
}

final class TransparentCollectionView: NSCollectionView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        fillColorBackground(.clear, dirtyRect: dirtyRect)
    }
}

final class TransparentScrollView: NSScrollView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        fillColorBackground(.clear, dirtyRect: dirtyRect)
    }
}

final class TransparentClipView: NSClipView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        fillColorBackground(.clear, dirtyRect: dirtyRect)
    }
}

final class LoadingView: TransparentView {

    @IBOutlet var progressIndicator: NSProgressIndicator?

    override func awakeFromNib() {
        super.awakeFromNib()
        isHidden = true
        wantsLayer = true
        progressIndicator?.startAnimation(self)
    }

    func startLoading() {
        isHidden = false
    }

    override var isHidden: Bool {
        didSet {
            progressIndicator?.isHidden = isHidden
        }
    }

    func stopLoading() {
        NSAnimationContext.runAnimationGroup({ _ in
            self.isHidden = true
        }, completionHandler: nil)
    }

}
