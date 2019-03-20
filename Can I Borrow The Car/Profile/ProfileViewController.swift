//
//  ProfileViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView! {
        didSet {
            AppStyle.circleUIView(image: userProfileImage)
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user: UserModel! {
        didSet {
            self.userNameLabel.text = user.username
            SdSetImage.fetchUserImage(image: userProfileImage, user: user)
        }
    }
    var cars: [CarModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        fetchMyCars()
        signOutBarButtonItem()
    }
    
    func fetchUser() {
        API.User.observeCurrentUser { user in
            self.user = user
        }
    }
    
    func fetchMyCars() {
        API.Car.observeMyCars { snapshot in
            API.Car.observeCarsWithId(withId: snapshot.key, completion: { car in
                self.cars.append(car)
            })
        }
    }
    
    func signOutBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit profile", style: .plain, target: self, action: #selector(editProfile))
    }
    
    @objc func editProfile() {
        performSegue(withIdentifier: Identifier.editProfile, sender: nil)
    }



}
