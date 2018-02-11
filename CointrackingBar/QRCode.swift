//
//  QRCode.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 11/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import AppKit

struct QRCode {
    let imageUrl: URL
    var image: NSImage? { return NSImage(contentsOf: imageUrl) }
    let currency: String
    let address: String

    init?(filename: String) {
        guard let url = QRCode.codes[filename] else { return nil }

        let name = url.lastPathComponent
        let nsName = name as NSString

        let matches = QRCode.expression.matches(in: name, options: [], range: nsName.range(of: name))
        guard let match = matches.first, match.numberOfRanges >= 3 else { return nil }

        self.imageUrl = url
        self.currency = nsName.substring(with: match.range(at: 1))
        let addressBase = nsName.substring(with: match.range(at: 2))
        self.address = match.numberOfRanges == 3 ? addressBase : "\(addressBase):\(nsName.substring(with: match.range(at: 3)))"
    }

    private static let expression = try! NSRegularExpression(pattern: "^(.*)-QR-Code-(.*-?.*).png$", options: [])

    private static let codes: [String: URL] = {
        let qrCodes = Bundle.resources(with: "png", type: "QR Codes")
        return qrCodes.reduce([String: URL]()) {
            var result = $0
            result[$1.lastPathComponent] = $1
            return result
        }
    }()
}

