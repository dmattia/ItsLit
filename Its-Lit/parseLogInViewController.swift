//
//  parseLogInViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/22/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class parseLogInViewController: PFLogInViewController, PFLogInViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.performSegueWithIdentifier("closeLogInSegue", sender: self)
    }
}
