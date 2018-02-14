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
        var ptr: NSArray? = nil
        guard
            let nib = DonationHeaderItemController.nib,
            nib.instantiate(withOwner: nil, topLevelObjects: &ptr),
            let array = ptr,
            let view = (array.flatMap { $0 as? NSView }).first
            else { return .zero }
        return view.fittingSize
    }
}
