//
//  LoadingView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 16/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class LoadingView: NSView {

    lazy var progressView: NSProgressIndicator = {
        let view = NSProgressIndicator()
        view.isIndeterminate = true
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
//        translatesAutoresizingMaskIntoConstraints = false
//        wantsLayer = true
//        addSubview(progressView)
//        NSLayoutConstraint.activate([
//            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            progressView.centerYAnchor.constraint(equalTo: centerYAnchor)
//            ])
    }

    override var wantsUpdateLayer: Bool {
        return true
    }

    override func updateLayer() {
        layer?.backgroundColor = NSColor.white.cgColor
    }

}
