//
//  detailViewViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/20/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit

class detailViewViewController: UIViewController {
    
    @IBOutlet var headerLabel: UILabel!
    var headerText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Header text: \(headerText!)")
        self.headerLabel.text = headerText
        print("Viewed detail page")
    }
}