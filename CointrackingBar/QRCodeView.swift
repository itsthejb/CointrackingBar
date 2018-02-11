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
        let view = NSStackView(views: [
            self.imageView, self.currencyLabel, self.addressLabel
            ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.edgeInsets = NSEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        view.orientation = .vertical
        view.alignment = .centerX
        view.distribution = .fill
        return view
    }()

    private lazy var imageView: NSImageView = {
        let view = NSImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.imageAlignment = .alignCenter
        view.imageScaling = .scaleProportionallyUpOrDown
        view.imageFrameStyle = .none
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
            ])
        return view
    }()

    private lazy var currencyLabel: NSTextField = {
        return QRCodeLabel(font: NSFont.boldSystemFont(ofSize: 16),
                           textColor: .black,
                           bordered: true,
                           selectable: false)
    }()

    private lazy var addressLabel: NSTextField = {
        return QRCodeLabel(font: NSFont.labelFont(ofSize: NSFont.labelFontSize),
                           textColor: .gray,
                           bordered: false,
                           selectable: true)
    }()

    override init(frame frameRect: NSRect) {
        fatalError("init(frame:) has not been implemented")
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        wantsLayer = true
        borderColor = .controlLightHighlightColor
        borderWidth = 1
        layer?.cornerRadius = 4
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
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            //
            addressLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
    }

    private func configure(withFilename filename: String?) {
        guard let filename = filename else { code = nil; return }
        loadViews()
        code = QRCode(filename: filename)
    }

    override func draw(_ dirtyRect: NSRect) {
        NSColor.white.set()
        NSRect.fill(dirtyRect)(using: .copy)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure(withFilename: filename)
    }

    private final class QRCodeLabel: NSTextField {
        init(font: NSFont, textColor color: NSColor, bordered: Bool, selectable: Bool) {
            super.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false
            setContentCompressionResistancePriority(.required, for: .vertical)
            setContentCompressionResistancePriority(.required, for: .horizontal)
            setContentHuggingPriority(.required, for: .vertical)
            setContentHuggingPriority(.defaultLow, for: .horizontal)
            textColor = color
            alignment = .center
            isEditable = false
            isBordered = bordered
            isSelectable = selectable
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

}
