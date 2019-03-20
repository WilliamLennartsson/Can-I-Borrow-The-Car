//
//  LoginViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class AuthPlaceholder: UITextField, Jiggerable {}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: AuthPlaceholder!
    @IBOutlet weak var passwordLabel: AuthPlaceholder!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func LogIn(_ sender: Any) {

    }


}
