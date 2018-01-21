//
//  WebView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 21/01/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import WebKit

final class WebView: WKWebView {

    override func awakeFromNib() {
        super.awakeFromNib()
        if NSAppKitVersion.current.rawValue > 1500 {
            setValue(false, forKey: "drawsBackground")
        }
        else {
            setValue(true, forKey: "drawsTransparentBackground")
        }
    }
    
}
