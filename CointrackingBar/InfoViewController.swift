//
//  InfoViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 23/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class InfoViewController: NSViewController, StoryboardViewController {

    @IBOutlet weak var collectionView: NSCollectionView!

    lazy var qrCodes = (Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: "QR Codes") ?? [])
        .flatMap { QRCode(with: $0) }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = NSNib(nibNamed: NSNib.Name("QRCodeCollectionViewCell"), bundle: nil)
        collectionView.register(nib, forItemWithIdentifier: QRCodeCollectionViewCell.identifier)
    }

}

extension InfoViewController: NSCollectionViewDataSource {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return qrCodes.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        return collectionView.makeItem(withIdentifier: QRCodeCollectionViewCell.identifier, for: indexPath)
    }

}

extension InfoViewController: NSCollectionViewDelegateFlowLayout {

}
