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
import FBSDKCoreKit
import ParseFacebookUtilsV4

class parseLogInViewController: PFLogInViewController, PFLogInViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.facebookPermissions = ["friends_about_me"]
        self.fields = [PFLogInFields.Facebook, PFLogInFields.Twitter, PFLogInFields.UsernameAndPassword, PFLogInFields.SignUpButton, PFLogInFields.LogInButton, PFLogInFields.PasswordForgotten, PFLogInFields.DismissButton]
        
        /*
        let logInButton = FBSDKLoginButton(frame: CGRect(x: 200, y: 200, width: 100, height: 40))
        self.view.addSubview(logInButton)
        */
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.performSegueWithIdentifier("closeLogInSegue", sender: self)
    }
    
    
}
