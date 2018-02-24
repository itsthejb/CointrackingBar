//
//  DonationHeaderItem.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 14/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DonationHeaderItem: NSCollectionViewItem {
    static let nibName = NSNib.Name(String(describing: DonationHeaderItem.self))
    static let nib = NSNib(nibNamed: nibName, bundle: Bundle.appBundle)

    @IBOutlet weak var titleLabel: TransparentTextField!
    @IBOutlet weak var contactLabel: TransparentTextField!
    @IBOutlet weak var donationLabel: TransparentTextField!

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
