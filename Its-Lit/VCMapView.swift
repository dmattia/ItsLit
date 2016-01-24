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

extension ViewController: MKMapViewDelegate {
    
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
                let query: PFQuery = PFQuery(className: "Event")
                query.getObjectInBackgroundWithId(annotation.objectID!) {
                    (event: PFObject?, error: NSError?) -> Void in
                    if(event != nil) {
                        let dictArray = event!.objectForKey("ratings") as! [Dictionary<String, CGFloat>]
                        let dict = dictArray[0]
                        var sum = 0 as CGFloat
                        for pair in dict {
                            sum = sum + pair.1
                        }
                        ratingView.value = sum / CGFloat(integerLiteral: dict.count)
                    }
                }
                
                let widthConstraint = NSLayoutConstraint(item: ratingView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100)
                ratingView.addConstraint(widthConstraint)
                
                let heightConstraint = NSLayoutConstraint(item: ratingView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 40)
                ratingView.addConstraint(heightConstraint)
                
                ratingView.allowsHalfStars = true
                ratingView.accurateHalfStars = true
                ratingView.backgroundColor = UIColor.clearColor()
                ratingView.userInteractionEnabled = false
                view.detailCalloutAccessoryView = ratingView
            }
            view.animatesDrop = true
            
            // Determine color based upon numer of users going to the event
            let query = PFQuery(className: "Event")
            query.getObjectInBackgroundWithId(annotation.objectID!) {
                (event: PFObject?, error: NSError?) -> Void in
                if error == nil && event != nil {
                    let going = event?.objectForKey("UsersGoing")?.count
                    if(going == 0) {
                        view.pinTintColor = UIColor.redColor()
                    } else if (going < 5) {
                        view.pinTintColor = UIColor.yellowColor()
                    } else if (going < 10){
                        view.pinTintColor = UIColor.orangeColor()
                    } else {
                        view.pinTintColor = UIColor.blueColor()
                    }
                } else {
                    print(error)
                }
            }
            
            return view
        }
        return nil
    }
    
    /*
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let ratingView: HCSStarRatingView = HCSStarRatingView(frame: CGRect(x: 0, y: -30, width: 80, height: 20))
        view.addSubview(ratingView)
        //view.bringSubviewToFront(ratingView)
    }
    */
    
}