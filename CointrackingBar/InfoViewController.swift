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
    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet weak var clipView: NSClipView!
    @IBOutlet weak var iconPopUpButton: NSPopUpButton!

    lazy var layoutHeader: NSViewController = { return DonationHeaderItemController.controller() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconPopUpButton.removeAllItems()
        iconPopUpButton.addItems(withTitles: BarIcon.icons.map { $0.name })
        collectionView.register(QRCodeViewItem.self,
                                forItemWithIdentifier: QRCodeViewItem.userInterfaceIdentifier)
        collectionView.register(DonationHeaderItemController.nib,
                                forSupplementaryViewOfKind: DonationHeaderItemController.elementKind,
                                withIdentifier: DonationHeaderItemController.userInterfaceIdentifier)
    }

    override func viewWillLayout() {
        super.viewWillLayout()
        clipView.frame = view.bounds
        collectionView.collectionViewLayout?.invalidateLayout()
    }
}

extension InfoViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return QRCode.codes.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: QRCodeViewItem.userInterfaceIdentifier, for: indexPath)
        guard let codeItem = item as? QRCodeViewItem else { return item }
        codeItem.code = QRCode.codes[indexPath.item]
        return codeItem
    }

    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        return collectionView.makeSupplementaryView(ofKind: DonationHeaderItemController.elementKind,
                                                    withIdentifier: DonationHeaderItemController.userInterfaceIdentifier,
                                                    for: indexPath)
    }
}

extension InfoViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView,
                        layout collectionViewLayout: NSCollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> NSSize {
        return layoutHeader.view.fittingSize
    }
}

final class QRCodeCollectionViewLayout: NSCollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: NSRect) -> Bool {
        guard let collectionView = collectionView, abs(newBounds.size.height - collectionView.frame.size.height) > 1E-2
            else { return false }
        collectionView.reloadSections(IndexSet(integer: 0))
        return true
    }
}
