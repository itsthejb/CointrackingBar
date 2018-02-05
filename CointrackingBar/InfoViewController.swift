//
//  InfoViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 23/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

struct QRCode {
    let url: URL
    let currency: String
    let address: String

    init?(with url: URL) {
        let name = url.lastPathComponent
        let nsName = name as NSString

        let matches = QRCode.expression.matches(in: name, options: [], range: nsName.range(of: name))
        guard let match = matches.first, match.numberOfRanges >= 3 else { return nil }

        self.url = url
        self.currency = nsName.substring(with: match.range(at: 1))
        let addressBase = nsName.substring(with: match.range(at: 2))
        self.address = match.numberOfRanges == 3 ? addressBase : "\(addressBase):\(nsName.substring(with: match.range(at: 3)))"
    }

    private static let expression = try! NSRegularExpression(pattern: "^(.*)-QR-Code-(.*)-(.*).png$", options: [])
}

final class InfoViewController: NSViewController, StoryboardViewController {

    @IBOutlet weak var collectionView: NSCollectionView!

    lazy var qrCodes = (Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: "QR Codes") ?? [])
        .flatMap { QRCode(with: $0) }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(qrCodes)
//        NSImage(
        // Do view setup here.
    }
    
}

extension InfoViewController: NSCollectionViewDataSource {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        return NSCollectionViewItem()
    }

}

extension InfoViewController: NSCollectionViewDelegateFlowLayout {

}
