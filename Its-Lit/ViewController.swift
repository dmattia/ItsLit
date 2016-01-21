//
//  ViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/20/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var clickedTitle: String?
    var clickedSubtitle: String?
    var newEventLocation: CLLocationCoordinate2D?
    
    @IBAction func logoutClicked(sender: AnyObject) {
        print("Logout clicked")
        PFUser.logOut()
        let viewController:PFLogInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! PFLogInViewController
        viewController.logInView?.logo = nil
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            if(PFUser.currentUser() == nil) {
                let viewController:PFLogInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! PFLogInViewController
                viewController.logInView?.logo = nil
                self.presentViewController(viewController, animated: true, completion: nil)
            }
        })
        // Clear all annotations
        let oldAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(oldAnnotations)
        
        // Add new annotations
        var annotations = [Artwork]()
        let query = PFQuery(className: "Event")
        query.findObjectsInBackgroundWithBlock { (events: [PFObject]?, error: NSError?) -> Void in
            for event in events! {
                let artwork = Artwork(title: event["Title"] as! String,
                    locationName: "",
                    discipline: event["type"] as! String,
                    coordinate: CLLocationCoordinate2D(latitude: event["location"].latitude, longitude: event["location"].longitude))
                
                annotations.append(artwork)
            }
            self.mapView.addAnnotations(annotations)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsBuildings = true;
        mapView.mapType = MKMapType.SatelliteFlyover;
        let initialLocation = CLLocation(latitude: 41.7030, longitude: -86.2390)
        centerMapOnLocation(initialLocation)
        
        let locationCoordinates = CLLocationCoordinate2DMake(41.7030,-86.2390)
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = locationCoordinates
        mapCamera.pitch = 45;
        mapCamera.altitude = 750;
        mapCamera.heading = 0;
        
        self.mapView.camera = mapCamera;
        self.mapView.delegate = self;
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        self.mapView.addGestureRecognizer(lpgr)
        
        print("View Did Load finished")
    }
    
    let regionRadius: CLLocationDistance = 2000;
    func centerMapOnLocation(location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if(gestureRecognizer.state == UIGestureRecognizerState.Began) {
            let locPressed = gestureRecognizer.locationInView(self.mapView)
            let mapCoordinate: CLLocationCoordinate2D = self.mapView.convertPoint(locPressed, toCoordinateFromView: self.mapView)
            
            self.newEventLocation = mapCoordinate
            
            self.performSegueWithIdentifier("createEventSegue", sender: self)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            let title = annotationView.annotation?.title!
            let subtitle = annotationView.annotation?.subtitle!
            print("Disclosure Pressed \(title!) with subtitle \(subtitle!)")
            self.clickedTitle = title
            self.clickedSubtitle = subtitle
            self.performSegueWithIdentifier("detailViewSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailViewSegue") {
            print("Preparing for segue to detail view...")
            let destinationViewController: detailViewViewController = segue.destinationViewController as! detailViewViewController
            destinationViewController.title = self.clickedTitle
            destinationViewController.headerText = self.clickedSubtitle
        } else if(segue.identifier == "createEventSegue") {
            print("Preparing for segue to create event...")
            let destinationViewController: addEventViewController = segue.destinationViewController as! addEventViewController
            destinationViewController.eventLocation = self.newEventLocation
            destinationViewController.title = "Create Event"
        }
    }
    
}

