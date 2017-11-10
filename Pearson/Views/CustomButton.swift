//
//  CustomButton.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        let layer = self.layer
        
        self.backgroundColor = UIColor.appMainColor()
        self.clipsToBounds = true
        layer.cornerRadius = 4.0
        
        self.setTitleColor(.white, for: .normal)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
    }

}
