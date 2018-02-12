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
    
    static func controller() -> Self {
        return NSStoryboard.with(class: self, storyboardNamed: "Info")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        iconPopUpButton.removeAllItems()
        iconPopUpButton.addItems(withTitles: BarIcon.icons.map { $0.name })
    }

    override func viewWillLayout() {
        super.viewWillLayout()
        clipView.frame = view.bounds
        collectionView.register(QRCodeView.self, forItemWithIdentifier: QRCodeView.identifier)
    }

}

extension InfoViewController: NSCollectionViewDataSource {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return QRCode.codes.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: QRCodeView.identifier, for: indexPath)
        guard let codeItem = item as? QRCodeView else { return item }
        codeItem.code = QRCode.codes[indexPath.item]
        return codeItem
    }
}

extension InfoViewController: NSCollectionViewDelegateFlowLayout {

}

