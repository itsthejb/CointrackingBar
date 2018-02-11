//
//  QRCodeView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 11/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

@IBDesignable
final class QRCodeView: TransparentView {

    @IBInspectable var filename: String? {
        didSet { configure(withFilename: filename) }
    }

    private var code: QRCode? {
        didSet {
            imageView.image = code?.image
            currencyLabel.stringValue = code?.currency ?? ""
            addressLabel.stringValue = code?.address ?? ""
        }
    }

    private lazy var stackView: NSStackView = {
        let view = NSStackView(views: [self.imageView, self.currencyLabel, self.addressLabel])
        view.orientation = .vertical
        view.alignment = .centerX
        view.distribution = .fillProportionally
        return view
    }()

    private lazy var imageView: NSImageView = {
        let view = NSImageView()
        view.imageAlignment = .alignCenter
        view.imageScaling = .scaleProportionallyUpOrDown
        view.imageFrameStyle = .none
//        NSLayoutConstraint.activate([
//            view.widthAnchor.constraint(equalToConstant: 200),
//            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
//            ])
        return view
    }()

    private lazy var currencyLabel: NSTextField = { return QRCodeLabel() }()
    private lazy var addressLabel: NSTextField = { return QRCodeLabel() }()

    override init(frame frameRect: NSRect) {
        fatalError("init(frame:) has not been implemented")
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        loadViews()
    }

    private func loadViews() {
        guard stackView.superview == nil else { return }
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
            ])
    }

    private func configure(withFilename filename: String?) {
        guard let filename = filename else { code = nil; return }
        loadViews()
        code = QRCode(filename: filename)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure(withFilename: filename)
    }

    private final class QRCodeLabel: NSTextField {

        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            alignment = .center
            isEditable = false
            isEnabled = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

}
