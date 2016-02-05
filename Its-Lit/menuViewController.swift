//
//  menuViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 2/5/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class menuViewController: UIViewController, PFLogInViewControllerDelegate {
    
    @IBOutlet weak var logoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoView.layer.cornerRadius = self.logoView.frame.width / 2
        self.logoView.layer.masksToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            if(PFUser.currentUser() == nil) {
                self.displayLogIn()
            }
        })
    }
    
    @IBAction func logoutClicked(sender: AnyObject) {
        print("Logout clicked")
        PFUser.logOut()
        self.displayLogIn()
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayLogIn() {
        let loginViewController = parseLogInViewController()
        loginViewController.delegate = self
        
        loginViewController.fields = [
            PFLogInFields.UsernameAndPassword,
            PFLogInFields.LogInButton,
            PFLogInFields.SignUpButton,
            PFLogInFields.PasswordForgotten,
            PFLogInFields.Twitter,
            PFLogInFields.Facebook
        ]
        
        //loginViewController.logInView?.logo = UIImageView(image: UIImage(named: "IMG_2233.JPG"))
        
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
}
