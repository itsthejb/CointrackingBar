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

