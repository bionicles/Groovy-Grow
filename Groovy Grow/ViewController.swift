//
//  ViewController.swift
//  Groovy Grow
//
//  Created by Bion Howard on 3/16/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//
// lat/lng lookup market api:
// http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat=" + lat + "&lng=" + lng
// get info on market
// http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id=" + id


import CoreLocation
import CoreData
import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    // map
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
//    let location: NSObject?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let distanceSpan:CLLocationDegrees = 36000
        let location = locations[0]
        //        let dojoLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.3753996, -121.9101584)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegionMakeWithDistance(myLocation, distanceSpan, distanceSpan)
        mapView.setRegion(region, animated: true)
        
//        get market data
        
//        for market in markets ... get data and draw pin
        
        let pin = Annotation(title:"Dojo", subtitle: "Josh is cool", coordinate: myLocation)
        mapView.addAnnotation(pin)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
//        var location:CLLocation = locationManager()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

