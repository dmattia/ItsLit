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
            }
            view.animatesDrop = true
            
            // Determine color based upon numer of users going to the event
            let query = PFQuery(className: "Event")
            query.getObjectInBackgroundWithId(annotation.objectID!) {
                (event: PFObject?, error: NSError?) -> Void in
                if error == nil && event != nil {
                    let going = event?.objectForKey("UsersGoing")?.count
                    if(going == 0) {
                        view.pinTintColor = UIColor.greenColor()
                    } else if (going < 3) {
                        view.pinTintColor = UIColor.yellowColor()
                    } else {
                        view.pinTintColor = UIColor.redColor()
                    }
                } else {
                    print(error)
                }
            }
            
            return view
        }
        return nil
    }
    
}