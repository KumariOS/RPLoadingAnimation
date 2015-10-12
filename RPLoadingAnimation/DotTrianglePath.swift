//
//  DotTrianglePath.swift
//  RPLoadingAnimation
//
//  Created by naoyashiga on 2015/10/12.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class DotTrianglePath: RPLoadingAnimationDelegate {
    var baseLayer = CALayer()
    var baseSize = CGSize(width: 0, height: 0)
    
    func setup(layer: CALayer, size: CGSize, color: UIColor) {
        
        let dotNum: CGFloat = 3
        let diameter: CGFloat = size.width / 5
        let dot = CALayer()
        let duration: CFTimeInterval = 1.5
        
        let frame = CGRect(
            x: (layer.bounds.width - diameter) / 2,
            y: (layer.bounds.height - diameter) / 2,
            width: diameter,
            height: diameter
        )
        
        baseLayer = layer
        baseSize = size
        
        dot.backgroundColor = color.CGColor
        dot.frame = frame
        dot.cornerRadius = diameter / 2
        
        let replicatorLayer = CAReplicatorLayer()
        
        replicatorLayer.frame = layer.bounds
        replicatorLayer.addSublayer(dot)
        
        replicatorLayer.instanceCount = Int(dotNum)
//        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(diameter + 10, 0, 0)
//        let angle = (2.0 * M_PI) / Double(replicatorLayer.instanceCount)
        
//        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        replicatorLayer.instanceDelay = CFTimeInterval(-1 / dotNum)
        
        layer.addSublayer(replicatorLayer)
        
        let moveAnimation = CAKeyframeAnimation(keyPath: "position")
        moveAnimation.path = getPath()
        moveAnimation.duration = duration
        moveAnimation.repeatCount = .infinity
        moveAnimation.timingFunction = TimingFunction.EaseInOutSine.getTimingFunction()
        dot.addAnimation(moveAnimation, forKey: "moveAnimation")
    }
    
    func getPath() -> CGPath {
        let r: CGFloat = baseSize.width / 2
        let center = CGPoint(x: baseLayer.bounds.width / 2, y: baseLayer.bounds.height / 2)
        let path = UIBezierPath()
        
        path.moveToPoint(CGPointMake(center.x, -r))
        path.addLineToPoint(CGPointMake(center.x - r, r / 2))
        path.addLineToPoint(CGPointMake(center.x + r, r / 2))
        path.closePath()
        
        return path.CGPath
    }
}