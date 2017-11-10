//
//  CourseCollectionViewCell.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit
import AlamofireImage

class CourseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var courseSubTitle: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    
    func configure(course: Course) {
        courseTitle.text = course.name
        courseSubTitle.text = course.subject
        
        if let url = course.thumbnailURL() {
            imageView.af_setImage(withURL: url)
        }
    }
}
