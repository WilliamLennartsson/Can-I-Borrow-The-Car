//
//  LoginViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class AuthPlaceholder: UITextField, Jiggerable {}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: AuthPlaceholder!
    @IBOutlet weak var passwordLabel: AuthPlaceholder!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func LogIn(_ sender: Any) {
        signInOnComplete(completion: {
            ProgressHUD.showSuccess("Logged in")
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    private func signInOnComplete(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        view.endEditing(true)
        ProgressHUD.show()
        AuthService.signIn(email: emailLabel.text!, password: passwordLabel.text!, signedIn: {
            completion()
        }) { (er) in
            error(er!)
        }
    }
}
