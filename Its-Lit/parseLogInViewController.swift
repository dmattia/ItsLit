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

class parseLogInViewController: PFLogInViewController {
    
    var backgroundImage : UIImageView!;

    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UILabel()
        logo.text = "IT'S LIT. So Sign Up."
        logo.textColor = UIColor.whiteColor()
        logo.font = UIFont(name: "Pacifico", size: 30)
        logo.shadowColor = UIColor.lightGrayColor()
        logo.shadowOffset = CGSizeMake(2, 2)
        logInView?.logo = logo
        
        logInView?.logInButton?.setBackgroundImage(nil, forState: .Normal)
        logInView?.logInButton?.backgroundColor = UIColor(red: 52/255, green: 125/255, blue: 255/255, alpha: 1)
        //self.logInView!.passwordForgottenButton?.backgroundColor = UIColor.whiteColor()
        logInView?.passwordForgottenButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)

        
        backgroundImage = UIImageView(image: UIImage(named: "Party"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.logInView!.insertSubview(backgroundImage, atIndex: 0)
        
        self.signUpController = ParseSignUpViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImage.frame = CGRectMake( 0,  0,  self.logInView!.frame.width,  self.logInView!.frame.height)
    }
}