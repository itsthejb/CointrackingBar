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
        let nib = NSNib(nibNamed: NSNib.Name(String(describing: QRCodeCollectionViewItem.self)), bundle: nil)
        collectionView.register(nib, forItemWithIdentifier: QRCodeCollectionViewItem.identifier)
    }

}

extension InfoViewController: NSCollectionViewDataSource {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return qrCodes.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: QRCodeCollectionViewItem.identifier, for: indexPath)
        guard let qrItem = item as? QRCodeCollectionViewItem else { return item }
        qrItem.code = qrCodes[indexPath.item]
        return qrItem
    }

}

extension InfoViewController: NSCollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
//        return NSSize(width: 200, height: 300)
//    }
}
