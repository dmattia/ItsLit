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
    
    @IBAction func saveEventButtonClicked(sender: AnyObject) {
        print("Saving Event...")
        let newEvent = PFObject(className: "Event")
        newEvent["Title"] = self.eventTitleTextField.text
        newEvent["type"] = self.typeTextField.text
        newEvent["location"] = PFGeoPoint(latitude: self.eventLocation!.latitude,
            longitude: self.eventLocation!.longitude)
        newEvent["UsersGoing"] = [PFUser.currentUser()!]
        newEvent.saveInBackgroundWithBlock { (saved: Bool, error: NSError?) -> Void in
            if(saved) {
                print("Saved Event")
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                print("Error Saving: \(error)")
            }
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