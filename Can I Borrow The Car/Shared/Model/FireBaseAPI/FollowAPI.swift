//
//  FollowAPI.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-12-17.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation
import Firebase

class FollowAPI {
    var Ref_Followers = Database.database().reference().child(AuthConfig.followers)
    var Ref_Following = Database.database().reference().child(AuthConfig.following)

    func followAction(withUser id: String){
        API.Car.refMyCars.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    Database.database().reference().child(AuthConfig.feedUrl).child(API.User.currentUser!.uid).child(key).setValue(true)                }
            }
        }
        Ref_Followers.child(id).child(API.User.currentUser!.uid).setValue(true)
        Ref_Following.child(API.User.currentUser!.uid).child(id).setValue(true)
    }

    func unFollowAction(withUser id: String){
        API.Car.refMyCars.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    Database.database().reference().child(AuthConfig.feedUrl).child(API.User.currentUser!.uid).child(key).removeValue()              }
            }
        }
        Ref_Followers.child(id).child(API.User.currentUser!.uid).setValue(NSNull())
        Ref_Following.child(API.User.currentUser!.uid).child(id).setValue(NSNull())
    }

    func isFollowing(userId: String, completed: ((Bool) -> ())? = nil) {
        Ref_Followers.child(userId).child(API.User.currentUser!.uid).observeSingleEvent(of: .value) { snapshot in
            if let _ = snapshot.value as? NSNull {
                completed!(false)
            } else {
                completed!(true)
            }
        }
    }
}
