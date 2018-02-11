//
//  BarIcon.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 11/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import AppKit

struct BarIcon {

    let name: String
    let url: URL
    var image: NSImage? { return NSImage(contentsOf: url) }

    init?(url: URL) {
        self.url = url
        self.name = url.deletingPathExtension().lastPathComponent
    }

    static let icons: [BarIcon] = {
        return Bundle.resources(with: "png", type: "Bar Icons")
            .filter { !$0.lastPathComponent.hasSuffix("@2x.png") }
            .flatMap { BarIcon(url: $0) }
            .sorted { $0.name < $1.name }
    }()

}
