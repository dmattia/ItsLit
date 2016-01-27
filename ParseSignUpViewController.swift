//
//  ParseSignUpViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/27/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ParseSignUpViewController : PFSignUpViewController {
    
    var backgroundImage : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set our custom background image
        backgroundImage = UIImageView(image: UIImage(named: "Party"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        signUpView!.insertSubview(backgroundImage, atIndex: 0)
        
        // remove the parse Logo
        let logo = UILabel()
        logo.text = "IT'S LIT. So Log in."
        logo.textColor = UIColor.whiteColor()
        logo.font = UIFont(name: "Pacifico", size: 30)
        logo.shadowColor = UIColor.lightGrayColor()
        logo.shadowOffset = CGSizeMake(2, 2)
        signUpView?.logo = logo
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  signUpView!.frame.width,  signUpView!.frame.height)
        
        // position logo at top with larger frame
        signUpView!.logo!.sizeToFit()
        let logoFrame = signUpView!.logo!.frame
        signUpView!.logo!.frame = CGRectMake(logoFrame.origin.x, signUpView!.usernameField!.frame.origin.y - logoFrame.height - 16, signUpView!.frame.width,  logoFrame.height)
    }
    
}