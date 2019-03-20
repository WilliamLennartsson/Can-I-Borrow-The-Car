//
//  SearchUsersViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [UserModel] = []
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchBar()
        doSearch()
    }
    

    
}
