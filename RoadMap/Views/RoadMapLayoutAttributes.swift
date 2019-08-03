//
//  RoadMapLayoutAttributes.swift
//  RoadMap
//
//  Created by Neil Jain on 8/3/19.
//  Copyright © 2019 Ratnesh Jain. All rights reserved.
//

import UIKit

class RoadMapLayoutAttributes: UICollectionViewLayoutAttributes {
    var numberOfItems: Int = 0
    var lineSpacing: CGFloat = 0
    var onTapAction: (()->Void)?
}
