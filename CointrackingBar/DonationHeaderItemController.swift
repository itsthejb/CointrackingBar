//
//  DonationHeaderItem.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 14/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DonationHeaderItemController: NSViewController, StoryboardViewController {
    static let elementKind = NSCollectionView.SupplementaryElementKind.sectionHeader
    static let nib = NSNib(nibNamed: NSNib.Name(String(describing: DonationHeaderItemController.self)),
                           bundle: Bundle.appBundle)

    @IBOutlet weak var titleLabel: TransparentTextField!
    @IBOutlet weak var contactLabel: TransparentTextField!
    @IBOutlet weak var donationLabel: TransparentTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
