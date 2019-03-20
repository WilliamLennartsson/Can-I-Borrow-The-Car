//
//  SignUpViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameLabel: AuthPlaceholder!
    @IBOutlet weak var emailLabel: AuthPlaceholder!
    @IBOutlet weak var passwordLabel: AuthPlaceholder!
    @IBOutlet weak var rePasswordLabel: AuthPlaceholder!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        userNameLabel.jigger()
        emailLabel.jigger()
        passwordLabel.jigger()
        rePasswordLabel.jigger()
    }
    

}
