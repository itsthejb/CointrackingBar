//
//  LoadingView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class LoadingView: TransparentView {

    @IBOutlet var progressIndicator: NSProgressIndicator?

    override func awakeFromNib() {
        super.awakeFromNib()
        isHidden = true
        wantsLayer = true
        progressIndicator?.startAnimation(self)
    }

    func startLoading() {
        isHidden = false
    }

    override var isHidden: Bool {
        didSet {
            progressIndicator?.isHidden = isHidden
        }
    }

    func stopLoading() {
        NSAnimationContext.runAnimationGroup({ _ in
            self.isHidden = true
        }, completionHandler: nil)
    }

}
