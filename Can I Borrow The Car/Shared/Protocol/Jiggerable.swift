//
//  Jitterable.swift
//  ProtocolJigger
//
//  Created by Kristoffer Knape on 2019-03-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

protocol Jiggerable {}

extension Jiggerable where Self: UIView {
    
    func jigger() {
        let key = "position"
        let animation = CABasicAnimation(keyPath: key)
        let cgXMinusPoint = CGPoint.init(x: self.center.x - 5.0, y: self.center.y)
        let cgXPlusPoint = CGPoint.init(x: self.center.x + 5.0, y: self.center.y)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: cgXMinusPoint)
        animation.toValue = NSValue(cgPoint: cgXPlusPoint)
        animation.duration = 0.05
        animation.repeatCount = 5
        layer.add(animation, forKey: key)
    }
}



