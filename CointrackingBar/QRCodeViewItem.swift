//
//  QRCodeView.swift
//  CointrackingBar
//
//  Created by Jonathan Crooke on 11/02/2018.
//  Copyright © 2018 Jonathan Crooke. All rights reserved.
//

import Cocoa

final class QRCodeViewItem: NSCollectionViewItem {

    static let identifier = NSUserInterfaceItemIdentifier(String(describing: self))

    @IBInspectable var filename: String? {
        didSet { configure(withFilename: filename) }
    }

    var code: QRCode? {
        didSet {
            codeImageView.image = code?.image
            currencyLabel.stringValue = code?.currency ?? ""
            addressLabel.stringValue = code?.address ?? ""
        }
    }

    private lazy var stackView: NSStackView = {
        let view = NSStackView(views: [
            self.codeImageView, self.currencyLabel, self.addressLabel
            ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.edgeInsets = NSEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        view.orientation = .vertical
        view.alignment = .centerX
        view.distribution = .fill
        return view
    }()

    private lazy var codeImageView: NSImageView = {
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

    override func loadView() {
        guard !isViewLoaded else { return }
        let view = BackgroundColorView(color: .white)
        view.wantsLayer = true
        view.borderColor = .controlLightHighlightColor
        view.borderWidth = 1
        view.layer?.cornerRadius = 4
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            addressLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
        self.view = view
    }

    private func configure(withFilename filename: String?) {
        guard let filename = filename else { code = nil; return }
        loadView()
        code = QRCode(filename: filename)
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
