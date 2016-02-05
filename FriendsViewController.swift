//
//  FriendsViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 2/5/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var friendsTableView: UITableView!
    let names = ["Rubeus", "Ron", "Ginny", "Dean", "Cho"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendsTableView.delegate = self
        self.friendsTableView.dataSource = self
        
        self.title = "Friends"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendListCell")!
        
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(indexPath.row + 1)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
}
