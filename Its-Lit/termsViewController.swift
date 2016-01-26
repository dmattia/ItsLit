//
//  termsViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/26/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit

class termsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}