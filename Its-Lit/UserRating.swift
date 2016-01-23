//
//  UserRating.swift
//  Its-Lit
//
//  Created by David Mattia on 1/22/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import Foundation

class UserRating {
    var userId: String?
    var rating: Double = 0.0
    
    func convertToJson() -> NSDictionary {
        let dict = NSDictionary(object: self.rating, forKey: self.userId!)
        print (dict)
        return dict
    }
}