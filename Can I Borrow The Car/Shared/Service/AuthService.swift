//
//  AuthService.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-10-17.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import ProgressHUD

class AuthService {

   static func signIn(email: String, password: String, signedIn: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil) {
      Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
         if let error = error {
            onError!(error.localizedDescription)
            return
         }
         signedIn!()
      }
   }

   static func signOut(currentVC: UIViewController) {
      do {
         try Auth.auth().signOut()
      } catch let logoutError {
         ProgressHUD.showError(logoutError.localizedDescription)
      }
      let storyboard = UIStoryboard(name: Identifier.SignInIdentifier, bundle: nil)
      let signInVC = storyboard.instantiateViewController(withIdentifier: Storyboard.SignInSB)
      currentVC.present(signInVC, animated: true, completion: nil)
   }

   static func autoSignIn(signedIn: ((UserModel) -> Void)? = nil) {
      if Auth.auth().currentUser != nil {
        API.User.observeCurrentUser { (user) in
            signedIn!(user)
        }
      }
   }
    
    static func signUp(username: String, email: String, password: String, firstName: String, lastName: String, imageData: Data, signedIn: (() -> Void)? = nil, onError: ((String?) -> Void)? = nil) {
      Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
         if error != nil {
            onError!(error!.localizedDescription)
            return
         }

         let uid = user?.user.uid
         let storageRef = Storage.storage().reference(forURL: AuthConfig.storageUrl).child(AuthConfig.profilePictureUrl).child(uid!)

        storageRef.putData(imageData, metadata: nil, completion: { (metaStorage, error) in
            if error != nil {
               return
            }
            storageRef.downloadURL(completion: { (url, error) in
                let profileImageUrl = url?.absoluteString
                self.setUserInfomation(profileImageUrl: profileImageUrl!, username: username, firstName: firstName, lastName: lastName, email: email, uid: uid!, signedIn: signedIn)
            })
        })
      })
   }

    static func setUserInfomation(profileImageUrl: String, username: String, firstName: String, lastName: String, email: String, uid: String, signedIn: (() -> Void)? = nil) {
      let ref = Database.database().reference()
      let usersReference = ref.child(AuthConfig.userUrl)
      let newUserReference = usersReference.child(uid)
        newUserReference.setValue([FIRModelStrings.username: username, FIRModelStrings.usernameLowerCase: username.lowercased(), FIRModelStrings.email: email, FIRModelStrings.firstName: firstName, FIRModelStrings.lastName: lastName , FIRModelStrings.profileImageUrl: profileImageUrl])
      signedIn!()
   }

}
