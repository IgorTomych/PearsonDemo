//
//  AuthTextField.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

class AuthTextField: UITextField {
    
    let sideOffset: UIOffset = UIOffset(horizontal: 8.0, vertical: 2.0)
    
    override func awakeFromNib() {
        if let textFont = self.font, let textPlaceholder = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: textPlaceholder,
                                                            attributes: [NSAttributedStringKey.font: textFont,
                                                                         NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        textRect = textRect.offsetBy(dx: sideOffset.horizontal, dy: sideOffset.vertical)
        textRect.size.width -= sideOffset.horizontal

        return textRect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var editingRect = super.editingRect(forBounds: bounds)
        editingRect = editingRect.offsetBy(dx: sideOffset.horizontal, dy: sideOffset.vertical)
        editingRect.size.width -= sideOffset.horizontal
        return editingRect
    }
}
