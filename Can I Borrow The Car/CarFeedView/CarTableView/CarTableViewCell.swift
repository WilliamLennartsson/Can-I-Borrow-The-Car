//
//  CarTableViewCell.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var licencePlate: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView! {
        didSet {
            AppStyle.cirlceUIImageView(image: ownerImageView)
        }
    }
    
    var car: CarModel? {
        didSet {
            fetchCarInformation()
        }
    }
    
    var user: UserModel? {
        didSet {
            fetchUserInformation()
        }
    }
    
    func fetchUserInformation() {
        SdSetImage.fetchUserImage(image: ownerImageView, user: user!, photo: nil)
    }
    
    func fetchCarInformation() {
        licencePlate.text = car?.licensePlate
        model.text = car?.model
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
