//
//  addEventViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/20/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//


import UIKit
import Parse

class addEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var eventTitleTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    let pickerData = ["Dorm", "House", "Other"]
    var eventLocation: CLLocationCoordinate2D?
    
    func eventWithNameExists(name: String) -> Bool {
        let query = PFQuery(className: "Event")
        query.whereKey("Title", equalTo: name)
        var error : NSError?
        let count = query.countObjects(&error)
        return count > 0
    }
    
    @IBAction func saveEventButtonClicked(sender: AnyObject) {
        if !eventWithNameExists(self.eventTitleTextField.text!) {
            print("Saving Event...")
            let newEvent = PFObject(className: "Event")
            newEvent["Title"] = self.eventTitleTextField.text
            newEvent["type"] = self.typeTextField.text
            newEvent["location"] = PFGeoPoint(latitude: self.eventLocation!.latitude,
                longitude: self.eventLocation!.longitude)
            newEvent["UsersGoing"] = [PFUser.currentUser()!]
            newEvent["shutdown"] = false
            let dict = Dictionary<String, CGFloat>()
            var array = [Dictionary<String, CGFloat>]()
            array.append(dict)
            newEvent["ratings"] = array
            
            newEvent.saveInBackgroundWithBlock { (saved: Bool, error: NSError?) -> Void in
                if(saved) {
                    print("Saved Event")
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    print("Error Saving: \(error)")
                }
            }
        } else {
            let alert = UIAlertController(title: "Error Saving",
                message: "A party with this name already exists. Try another.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                print("OK Pressed")
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView: UIPickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        self.typeTextField.inputView = pickerView
        self.typeTextField.text = pickerData[0]
        
        print("Location is: \(self.eventLocation!)")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeTextField.text = pickerData[row]
    }
}