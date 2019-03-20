//
//  MainViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-18.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: SelfSizedCarTableView!
    
    let tableHeight = 140
    
    var count: Int = 0 {
        didSet {
            if count <= 0 {
                count = 0
                tableView.isHidden = true
            } else if count > 0 {
                tableView.isHidden = false
                tableView.reloadData()                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.maxHeight = 372
        tableView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        tableView.estimatedRowHeight = CGFloat(tableHeight)
    }

    @IBAction func minus(_ sender: Any) {
        count = count - 1
    }
    
    @IBAction func test(_ sender: Any) {
        count = count + 1
        tableView.scrollToRow(at: IndexPath(row:count-1, section:0), at: .bottom, animated: true)
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarUICell", for: indexPath) as! CarTableViewCell
        cell.Model.text = "Walla brroooor"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableHeight)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available cars"
    }
    
}
