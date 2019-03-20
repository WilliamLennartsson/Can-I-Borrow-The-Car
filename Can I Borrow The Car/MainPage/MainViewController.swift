//
//  MainViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-18.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: SelfSizedCarTableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    let tableHeight = 140
    
    var users = [UserModel]()
    var cars: [CarModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(API.User.currentUser!.uid)
        fetchCars()
        tableView.isHidden = false
        //tableView.maxHeight = 372
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authService()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.estimatedRowHeight = CGFloat(tableHeight)
    }
    
    
    func fetchUser(uid: String, completion: @escaping () -> Void) {
        authService()
        API.User.observeCurrentUser { user in
            self.users.append(user)
            completion()
        }
    }
    
    func fetchCars() {
        API.Feed.observeFeed(withId: API.User.currentUser!.uid) { (car) in
            guard let carId = car.userId else { return }
            self.fetchUser(uid: carId, completion: {
                self.cars.append(car)
            })
        }
        
        API.Feed.observeFeedRemoved(withId: API.User.currentUser!.uid) { (car) in
            self.users = self.users.filter { $0.id != car.id }
            self.cars = self.cars.filter { $0.id != car.id }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        ProgressHUD.show()
        AuthService.signOut {
            ProgressHUD.show("Signed out")
            self.authService()
            ProgressHUD.dismiss()
        }
    }
    
    func authService() {
        AuthService.authServiceHandler(signedIn: {
            tableView.isHidden = false
        }) {
            tableView.isHidden = true
        }
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarUICell", for: indexPath) as! CarTableViewCell
        let car = cars[indexPath.row]
        let user = users[indexPath.row]
        
        cell.car = car
        cell.user = user
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableHeight)
    }
    
}
