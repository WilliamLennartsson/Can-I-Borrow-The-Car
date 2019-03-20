//
//  SelfSizedCarTableView.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-18.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class SelfSizedCarTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
