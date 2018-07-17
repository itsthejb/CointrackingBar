//
//  BarIcon.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 11/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import AppKit

final class BarIcon: NSObject {
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
            .compactMap { BarIcon(url: $0) }
            .sorted { $0.name < $1.name }
    }()

    static let iconMap: [String: BarIcon] = {
        return icons.reduce([String: BarIcon]()) {
            var result = $0
            result[$1.name] = $1
            return result
        }
    }()

    static let barIconPreferenceDidChange = Notification.Name("barIconPreferenceDidChange")
    static let `default` = BarIcon.iconMap["btc-black"]
}

extension UserDefaults {
    struct Keys {
        static let barIconName = prefixed("barIconName")

        static func prefixed(_ key: String) -> String {
            return Bundle.main.bundleIdentifier!
        }
    }

    var barIcon: BarIcon? {
        get {
            guard let name = string(forKey: Keys.barIconName) else { return BarIcon.default }
            return BarIcon.iconMap[name]
        }
        set {
            set(barIcon?.name, forKey: Keys.barIconName)
            NotificationCenter.default.post(name: BarIcon.barIconPreferenceDidChange, object: barIcon)
        }
    }
}
