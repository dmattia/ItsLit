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
    @IBOutlet var numberGoingLabel: UILabel!
    @IBOutlet var starRatingView: HCSStarRatingView!
    var headerText: String?
    var userCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func saveRatingClicked(sender: AnyObject) {
        let query = PFQuery(className: "Event")
        query.whereKey("Title", equalTo: self.title!)
        query.findObjectsInBackgroundWithBlock {
            (events: [PFObject]?, error: NSError?) -> Void in
            if(events != nil && events!.count == 1) {
                let event = events![0]
                
                // Update @event to have the new rating for this user
                var dictArray = event["ratings"] as! [Dictionary<String, CGFloat>]
                var dict = dictArray[0]
                dict[PFUser.currentUser()!.objectId!] = self.starRatingView.value
                dictArray[0] = dict
                event.setObject(dictArray, forKey: "ratings")
                
                event.saveInBackgroundWithBlock({ (completed: Bool, error: NSError?) -> Void in
                    if(completed) {
                        let alert = UIAlertController(title: "Success", message: "Your rating has been saved", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Could not save rating. Check internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                })
                
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