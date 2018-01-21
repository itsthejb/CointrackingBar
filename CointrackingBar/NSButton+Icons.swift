//
//  NSButton+Icons.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 17/12/2017.
//  Copyright © 2017 Jonathan Crooke. All rights reserved.
//

import Cocoa

extension NSButton {

    enum Icon {
        case forwards, backwards, info
    }

    func set(icon: Icon) {
        font = NSFont(name: "FontAwesome5FreeSolid", size: 20)
        title = icon.iconString
    }

}

private extension NSButton.Icon {

    var iconString: String {
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
