//
//  CarAPI.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CarApi {
    
    let refCarUrl = Database.database().reference().child(AuthConfig.carUrl)
    let refCarStorage = Storage.storage().reference(forURL: AuthConfig.storageUrl).child(AuthConfig.carUrl)
    var refMyCars = Database.database().reference().child(AuthConfig.myCarsUrl)
    
    func observeMyCars(uploaded: @escaping (DataSnapshot) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        refMyCars.child(currentUser.uid).observe(.childAdded) { snapshot in
            uploaded(snapshot)
        }
    }

    
    func observeCarsWithId(withId id: String, completion: @escaping (CarModel) -> Void) {
        refCarUrl.child(id).observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]  {
                let key = snapshot.key
                let car = CarModel.transformCarToDict(dict: dict, key: key)
                completion(car)
            }
        }
    }
    
}

//MARK - CRUD
extension CarApi {
    
    func uploadCar(carName: String, licencePlate: String, model: String, imageData: Data, completion: @escaping () -> ()) {
        let photoString = UUID().uuidString
        refCarStorage.child(photoString)
        refCarStorage.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!)
            }
            self.refCarStorage.downloadURL(completion: { (url, error) in
                if error != nil {
                    return
                }
                let carImageUrl = url?.absoluteString
                self.sendCarDataToDatabase(potoUrl: carImageUrl!, carName: carName, licencePlate: licencePlate, model: model, completion: completion)
            })
            
        }
    }
    
    private func sendCarDataToDatabase(potoUrl: String, carName: String, licencePlate: String, model: String, completion: @escaping () -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newCarId = refCarUrl.childByAutoId().key
        let newCarReference = refCarUrl.child(newCarId!)
        let currentUserId = currentUser.uid
        
        newCarReference.setValue([FIRModelStrings.uid: currentUserId, FIRModelStrings.name : carName, FIRModelStrings.model: model, FIRModelStrings.licensePlate: licencePlate]) { (error, _) in
            if error != nil {
                return
            }
            
            API.Feed.refFeed.child(currentUserId).child(newCarId!).setValue(true)
            self.refMyCars.child(currentUserId).child(newCarId!).setValue(true)
            completion()
        }
        
    }
    
}
