//
//  FeedAPI.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import Firebase

class FeedAPI {
    var refFeed = Database.database().reference().child(AuthConfig.feedUrl)

    func observeFeed(withId id: String, completion: ((CarModel) -> ())? = nil) {
        refFeed.child(id).observe(.childAdded) { (snapshot) in
            let key = snapshot.key
            API.Car.observeCarsWithId(withId: key, completion: { (post) in
                completion!(post)
            })
        }
    }

    func observeFeedRemoved(withId id: String, completion: ((CarModel) -> ())? = nil) {
        refFeed.child(id).observe(.childRemoved, with: {
            snapshot in
            let key = snapshot.key
            API.Car.observeCarsWithId(withId: key, completion: { (post) in
                completion!(post)
            })
        })
    }
}
