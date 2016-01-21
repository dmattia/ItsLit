//
//  detailViewViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/20/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit
import Parse

class detailViewViewController: UIViewController {
    
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var goingSwitch: UISwitch!
    var headerText: String?
    var userCount: Int = 0
    @IBOutlet var numberGoingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Header text: \(headerText!)")
        self.headerLabel.text = headerText
        
        // Set @goingSwitch to on or off based on if user is already going to event
        let query = PFQuery(className: "Event")
        query.whereKey("Title", equalTo: self.title!)
        query.findObjectsInBackgroundWithBlock {
            (events: [PFObject]?, error: NSError?) -> Void in
            if(events != nil && events!.count == 1) {
                let event = events![0]
                let usersGoing: [PFUser] = event.objectForKey("UsersGoing") as! [PFUser]
                
                // check if current User is already going to Event
                var alreadyIn = false
                for user in usersGoing {
                    if(user.objectId == PFUser.currentUser()?.objectId) {
                        alreadyIn = true
                    }
                }
                if(alreadyIn) {
                    self.goingSwitch.setOn(true, animated: true)
                }
                self.userCount = usersGoing.count
                self.numberGoingLabel.text = "Number Going: \(self.userCount)"
            } else {
                print("Query failed: \(error)")
            }
        }
    }
    
    @IBAction func goingSwitchToggled(sender: AnyObject) {
        if(self.goingSwitch.on) {
            self.userCount++
            self.numberGoingLabel.text = "Number Going: \(self.userCount)"
            
            // Add currentUser to array going to this event
            let query = PFQuery(className: "Event")
            query.whereKey("Title", equalTo: self.title!)
            query.findObjectsInBackgroundWithBlock {
                (events: [PFObject]?, error: NSError?) -> Void in
                if(events != nil && events!.count == 1) {
                    let event = events![0]
                    var usersGoing: [PFUser] = event.objectForKey("UsersGoing") as! [PFUser]
                    
                    // check if current User is already going to Event
                    var alreadyIn = false
                    for user in usersGoing {
                        if(user.objectId == PFUser.currentUser()?.objectId) {
                            alreadyIn = true
                        }
                    }
                    if(!alreadyIn) {
                        usersGoing.append(PFUser.currentUser()!)
                        event.setObject(usersGoing, forKey: "UsersGoing")
                        event.saveInBackground()
                    }
                } else {
                    print("Query failed: \(error)")
                }
            }

        } else {
            // Clear currentUser from the array going to this event
            self.userCount--
            self.numberGoingLabel.text = "Number Going: \(self.userCount)"

            let query = PFQuery(className: "Event")
            query.whereKey("Title", equalTo: self.title!)
            query.findObjectsInBackgroundWithBlock {
                (events: [PFObject]?, error: NSError?) -> Void in
                if(events != nil && events!.count == 1) {
                    let event = events![0]
                    var usersGoing: [PFUser] = event.objectForKey("UsersGoing") as! [PFUser]
                    usersGoing.append(PFUser.currentUser()!)
                    var updated = [PFUser]()
                    for user in usersGoing {
                        if(user.objectId != PFUser.currentUser()!.objectId) {
                            updated.append(user)
                        }
                    }
                    event.setObject(updated, forKey: "UsersGoing")
                    event.saveInBackground()
                } else {
                    print("Query failed: \(error)")
                }
            }
        }
    }
}