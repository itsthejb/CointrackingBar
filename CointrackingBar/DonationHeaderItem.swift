//
//  DonationHeaderItem.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 14/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class DonationHeaderItem: NSView {

    static let elementKind = NSCollectionView.SupplementaryElementKind.sectionHeader
    static let nib = NSNib(nibNamed: NSNib.Name(String(describing: DonationHeaderItem.self)),
                           bundle: Bundle.appBundle)
    
}
