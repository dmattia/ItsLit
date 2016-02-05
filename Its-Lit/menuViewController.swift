//
//  menuViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 2/5/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit

class menuViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoView.layer.cornerRadius = self.logoView.frame.width / 2
        self.logoView.layer.masksToBounds = true
    }
}
