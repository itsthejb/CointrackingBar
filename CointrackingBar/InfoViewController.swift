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
    @IBOutlet weak var iconPopUpButton: NSPopUpButton!
    
    static func controller() -> Self {
        return NSStoryboard.with(class: self, storyboardNamed: "Info")
    }

    override func viewWillLayout() {
        super.viewWillLayout()
        clipView.frame = view.bounds
    }

}
