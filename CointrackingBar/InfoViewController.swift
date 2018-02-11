//
//  InfoViewController.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 23/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class InfoViewController: NSViewController, StoryboardViewController {

    @IBOutlet var scrollView: NSScrollView!
    @IBOutlet weak var clipView: NSClipView!

    static func controller() -> Self {
        return NSStoryboard.with(class: self, storyboardNamed: "Info")
    }

    override func viewWillLayout() {
        super.viewWillLayout()
        clipView.frame = view.bounds
//        guard let parent = parent else { return }
//        clipView.frame = NSRect(x: 0, y: 0, width: parent.view.frame.width, height: .leastNonzeroMagnitude)
//        clipView.layout()
//        clipView.frame = NSRect(x: 0, y: 0, width: parent.view.frame.width, height: scrollView.contentSize.height)
    }

    override func viewDidLayout() {
        super.viewDidLayout()
     //   clipView.frame = NSRect(origin: .zero, size: scrollView.contentSize)
    }

}
