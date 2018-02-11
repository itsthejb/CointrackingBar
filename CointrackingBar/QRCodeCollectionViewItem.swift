//
//  QRCodeCollectionViewCell.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 05/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class QRCodeCollectionViewItem: NSCollectionViewItem {

    static let identifier = NSUserInterfaceItemIdentifier(String(describing: self))

    @IBOutlet weak var codeImageView: NSImageView!
    @IBOutlet weak var currencyLabel: NSTextField!
    @IBOutlet weak var addressLabel: NSTextField!

    var code: QRCode? {
        didSet {
            codeImageView?.image = code?.image
            currencyLabel?.stringValue = code?.currency ?? ""
            addressLabel?.stringValue = code?.address ?? ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        [currencyLabel, addressLabel].forEach { $0.setEdit}
    }

}

struct QRCode {

    let imageUrl: URL
    var image: NSImage? { return NSImage(contentsOf: imageUrl) }
    let currency: String
    let address: String

    init?(with url: URL) {
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
}

