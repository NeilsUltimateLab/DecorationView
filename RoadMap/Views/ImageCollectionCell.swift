//
//  ImageCollectionCell.swift
//  RoadMap
//
//  Created by Neil Jain on 8/3/19.
//  Copyright © 2019 Ratnesh Jain. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with image: UIImage) {
        self.imageView.image = image
    }

}
