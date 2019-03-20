//
//  Protocol+UIView.swift
//  ProtocolJigger
//
//  Created by Kristoffer Knape on 2019-03-14.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

protocol Flashable {}

extension Flashable where Self: UIView {
    
    func flash() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }) { (animationComplete) in
            if animationComplete == true {
                UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                    self.alpha = 0.0
                }, completion: nil)
            }
        }
    }
}
