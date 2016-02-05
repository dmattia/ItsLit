//
//  CampusesViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 2/5/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit

class CampusesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var campusesTableView: UITableView!
    let pictureNames = ["notre dame",
        "ohio state",
        "michigan",
        "Wisconsin",
        "Purdue"]
    let campuses = ["Notre Dame",
        "Ohio State",
        "Michigan Ann Arbor",
        "Wisconsin Madison",
        "Purdue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.campusesTableView.delegate = self
        self.campusesTableView.dataSource = self
        
        self.title = "Campuses"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campuses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("campusCell", forIndexPath: indexPath) as! CampusTableViewCell
        
        let image = UIImage(named: pictureNames[indexPath.row])
        cell.campusImageView?.image = image
        cell.campusNameLabel!.text = campuses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
}
