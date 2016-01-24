//
//  SettingsViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/24/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit

class SettingsViewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.92)
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        print("Saving")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        print("Cancelling")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
