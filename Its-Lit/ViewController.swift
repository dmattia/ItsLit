//
//  ViewController.swift
//  Its-Lit
//
//  Created by David Mattia on 1/20/16.
//  Copyright © 2016 David Mattia. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var clickedTitle: String?
    var clickedSubtitle: String?
    
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
        
        let artwork = Artwork(title: "Golden Dome",
            locationName: "Main Admissions Building",
            discipline: "House",
            coordinate: CLLocationCoordinate2D(latitude: 41.7030, longitude: -86.2390))
        let artwork2 = Artwork(title: "Stanford Hall",
            locationName: "Best Residence Hall on Campus",
            discipline: "Dorm",
            coordinate: CLLocationCoordinate2D(latitude: 41.7046474, longitude: -86.2396016))
        
        mapView.addAnnotation(artwork)
        mapView.addAnnotation(artwork2)
        print("View Did Load finished")
    }
    
    let regionRadius: CLLocationDistance = 2000;
    func centerMapOnLocation(location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
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
        }
    }
    
}

