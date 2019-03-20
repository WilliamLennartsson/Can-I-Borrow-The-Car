//
//  UsersTableViewCell.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView! {
        didSet {
            AppStyle.cirlceUIImageView(image: userProfileImageView)
        }
    }
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var isFollowingButton: UIButton!
    
    var user: UserModel? {
        didSet {
            updateView()
            updateFollowButton()
        }
    }
    
    func updateView() {
        userNameText.text = user?.username
        SdSetImage.fetchUserImage(image: userProfileImageView, user: user!, photo: nil)
    }
    
    func updateFollowButton() {
        API.Follow.isFollowing(userId: user!.id!) { (value) in
            if value == true{
                self.configureUnfollowButton()
            } else {
                self.configureFollowButton()
            }
        }
    }
    
    func configureFollowButton() {
        self.isFollowingButton.setTitle("Follow", for: .normal)
        isFollowingButton.addTarget(self, action: #selector(self.followAction), for: UIControl.Event.touchUpInside)
    }
    
    func configureUnfollowButton() {
        self.isFollowingButton.setTitle("Following", for: .normal)
        isFollowingButton.addTarget(self, action: #selector(self.unFollowAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func followAction() {
        if user!.isFollowing! == false {
            API.Follow.followAction(withUser: user!.id!)
            configureUnfollowButton()
            user!.isFollowing! = true
        }
    }
    
    @objc func unFollowAction() {
        if user!.isFollowing! == true {
            API.Follow.unFollowAction(withUser: user!.id!)
            configureFollowButton()
            user!.isFollowing! = false
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
