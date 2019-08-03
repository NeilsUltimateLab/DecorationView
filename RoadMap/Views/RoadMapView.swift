//
//  RoadMapView.swift
//  RoadMap
//
//  Created by Neil Jain on 8/3/19.
//  Copyright © 2019 Ratnesh Jain. All rights reserved.
//

import UIKit

class RoadMapView: UICollectionReusableView {
    var numberOfItems: Int = 0
    var lineSpacing: CGFloat = 0
    var inset: CGFloat = 16
    var cornerRadius: CGFloat = 60
    
    var onTapAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction() {
        print("DecorationView tapped")
        self.onTapAction?()
    }
    
    private var roadLayer = CAShapeLayer()
    private var deviderLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        let individualHeight = rect.height / CGFloat(numberOfItems)
        var previousHeight: CGFloat = 0
        
        for i in 0...numberOfItems {
            self.addArc(to: path, at: i, height: previousHeight, width: rect.width - inset - cornerRadius, indieHeight: individualHeight)
            previousHeight += individualHeight
        }
        
        roadLayer.frame = rect
        roadLayer.path = path.cgPath
        roadLayer.lineWidth = 32
        roadLayer.lineCap = .round
        roadLayer.lineJoin = .round
        roadLayer.strokeColor = UIColor.black.cgColor
        roadLayer.fillColor = UIColor.clear.cgColor
        
        deviderLayer.frame = rect
        deviderLayer.path = path.cgPath
        deviderLayer.lineWidth = 6
        deviderLayer.lineCap = .round
        deviderLayer.lineJoin = .round
        deviderLayer.lineDashPattern = [30, 30]
        deviderLayer.strokeColor = UIColor.white.cgColor
        deviderLayer.fillColor = UIColor.clear.cgColor
        
        roadLayer.removeFromSuperlayer()
        deviderLayer.removeFromSuperlayer()
        
        self.layer.addSublayer(roadLayer)
        self.layer.addSublayer(deviderLayer)
    }
    
    private func addArc(to path: UIBezierPath, at iteration: Int, height: CGFloat, width: CGFloat, indieHeight: CGFloat) {
        let isEven = iteration.isMultiple(of: 2)
        let isLeft = !isEven
        
        let xOrigin = isEven ? (0 + inset + cornerRadius) : (width - inset - cornerRadius)
        
        if height == 0 {
            path.move(to: CGPoint(x: inset, y: inset))
        }
        
        if height > cornerRadius {
            if isLeft {
                if iteration > 1 {
                    path.addArc(withCenter: CGPoint(x: inset + cornerRadius, y: height - indieHeight + cornerRadius), radius: cornerRadius, startAngle: -.pi/2, endAngle: -.pi, clockwise: false)
                }
                // Left Vertical
                path.addLine(to: CGPoint(x: inset, y: height - cornerRadius))
                // Bottom Left
                path.addArc(withCenter: CGPoint(x: inset + self.cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: -.pi, endAngle: -3 * .pi/2, clockwise: false)
            } else {
                // Top Right
                path.addArc(withCenter: CGPoint(x: width, y: height - indieHeight + cornerRadius), radius: cornerRadius, startAngle: 3 * .pi/2, endAngle: 0, clockwise: true)
                // bottom Right
                path.addArc(withCenter: CGPoint(x: width, y: height - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: .pi/2, clockwise: true)
                // Right Vertical
                path.addLine(to: CGPoint(x: width, y: height))
            }
            path.addLine(to: CGPoint(x: xOrigin, y: height))
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let roadMapAttributes = layoutAttributes as? RoadMapLayoutAttributes {
            self.numberOfItems = roadMapAttributes.numberOfItems
            self.lineSpacing = roadMapAttributes.lineSpacing
            self.onTapAction = roadMapAttributes.onTapAction
            self.setNeedsDisplay()
        }
    }
}
