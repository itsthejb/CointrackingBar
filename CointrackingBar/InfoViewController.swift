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

    enum Section: Int {
        case header = 0, codes
        static let all: [Section] = [.header, .codes]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconPopUpButton.removeAllItems()
        iconPopUpButton.addItems(withTitles: BarIcon.icons.map { $0.name })
        collectionView.register(QRCodeViewItem.self,
                                forItemWithIdentifier: QRCodeViewItem.userInterfaceIdentifier)
        collectionView.register(DonationHeaderItemController.nib,
                                forItemWithIdentifier: DonationHeaderItemController.userInterfaceIdentifier)
    }

    override func viewWillLayout() {
        super.viewWillLayout()
        clipView.frame = view.bounds
        collectionView.collectionViewLayout?.invalidateLayout()
    }
}

extension InfoViewController: NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return Section.all.count
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }

        switch section {
        case .header:
            return 1
        case .codes:
            return QRCode.codes.count
        }
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let blankItem = NSCollectionViewItem()
        guard let section = Section(rawValue: indexPath.section) else { return blankItem }

        switch section {
        case .header:
            return collectionView.makeItem(withIdentifier: DonationHeaderItemController.userInterfaceIdentifier,
                                           for: indexPath)
        case .codes:
            guard
                let item = collectionView.makeItem(withIdentifier: QRCodeViewItem.userInterfaceIdentifier, for: indexPath) as? QRCodeViewItem
                else { return blankItem }
            item.code = QRCode.codes[indexPath.item]
            return item
        }
    }
}

extension InfoViewController: NSCollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: NSCollectionView,
//                        layout collectionViewLayout: NSCollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> NSSize {
//        return layoutHeader.view.fittingSize
//    }
}

