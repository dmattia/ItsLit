//
//  VCMapView.swift
//  Its-Lit
//
//  Created by David Mattia on 1/20/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import Foundation
import MapKit
import Parse

extension ViewController {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                
                // Create rating view in callout
                let ratingView = HCSStarRatingView(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
                
                let widthConstraint = NSLayoutConstraint(item: ratingView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100)
                ratingView.addConstraint(widthConstraint)
                
                let heightConstraint = NSLayoutConstraint(item: ratingView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 40)
                ratingView.addConstraint(heightConstraint)
                
                ratingView.allowsHalfStars = true
                ratingView.accurateHalfStars = true
                ratingView.backgroundColor = UIColor.clearColor()
                ratingView.userInteractionEnabled = false
                view.detailCalloutAccessoryView = ratingView
                view.animatesDrop = true
            }
            let query: PFQuery = PFQuery(className: "Event")
            query.getObjectInBackgroundWithId(annotation.objectID!) {
                (event: PFObject?, error: NSError?) -> Void in
                if(event != nil) {
                    let dictArray = event!.objectForKey("ratings") as! [Dictionary<String, CGFloat>]
                    let dict = dictArray[0]
                    if(dict.count > 0) {
                        var sum = 0 as CGFloat
                        for pair in dict {
                            sum = sum + pair.1
                        }
                        (view.detailCalloutAccessoryView as! HCSStarRatingView).value = sum / CGFloat(integerLiteral: dict.count)
                    } else {
                        (view.detailCalloutAccessoryView as! HCSStarRatingView).value = 0
                    }
                    
                    if(!(event!["shutdown"] as! Bool)) {
                        let going = event?.objectForKey("UsersGoing")?.count
                        if(going == 0) {
                            view.pinTintColor = UIColor.redColor()
                        } else if (going < 2) {
                            view.pinTintColor = UIColor.yellowColor()
                        } else if (going < 3){
                            view.pinTintColor = UIColor.orangeColor()
                        } else {
                            view.pinTintColor = UIColor.blueColor()
                        }
                    } else {
                        view.pinTintColor = UIColor.blackColor()
                    }
                }
            }
            return view
        }
        return nil
    }
}