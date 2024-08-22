//
//  UILabel+Extensions.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 22.08.2024.
//

import UIKit

class PaddedLabel: UILabel {
    
    var textInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5) {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += textInsets.top + textInsets.bottom
        size.width += textInsets.left + textInsets.right
        return size
    }
}
