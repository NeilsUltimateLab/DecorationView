//
//  RoadMapLayout.swift
//  RoadMap
//
//  Created by Neil Jain on 8/3/19.
//  Copyright © 2019 Ratnesh Jain. All rights reserved.
//

import UIKit

class RoadMapLayout: UICollectionViewFlowLayout {
    
    private var decorationAttributes: UICollectionViewLayoutAttributes?
    var onTapAction: (()->Void)?
    
    override init() {
        super.init()
        setupDecorationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDecorationView()
    }
    
    private func setupDecorationView() {
        self.register(RoadMapView.self, forDecorationViewOfKind: "RoadMapView")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        let attributes = RoadMapLayoutAttributes(forDecorationViewOfKind: "RoadMapView", with: IndexPath(item: 0, section: 0))
        attributes.zIndex = 100
        attributes.frame = CGRect(x: 0, y: 0, width: collectionViewContentSize.width, height: collectionViewContentSize.height)
        attributes.numberOfItems = collectionView.numberOfItems(inSection: 0)
        attributes.lineSpacing = self.minimumLineSpacing
        attributes.onTapAction = self.onTapAction
        self.decorationAttributes = attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)
        if let decorationAttributes = self.decorationAttributes, decorationAttributes.frame.intersects(rect) {
            attributes?.append(decorationAttributes)
        }
        return attributes
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return decorationAttributes
    }
}
