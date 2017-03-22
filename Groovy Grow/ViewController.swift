//
//  ViewController.swift
//  Groovy Grow
//
//  Created by Bion Howard, Sarah Fogarty, Sarah Drake, and Josh Buttram on 3/16/17.
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
//    @IBOutlet weak var inputZip: UISearchBar!
//    var resultSearchController:UISearchController? = nil

    let lookupstring = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat="
    let detailstring = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id="
    
    let manager = CLLocationManager()
    var markets = [NSMutableDictionary]()
    var ids = [String]()
    var names = [String]()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error fetching location")
    }
    
    func getMarkets(lat: Double, lng: Double) {
        let url = URL(string: "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat=\(lat)&lng=\(lng)")
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let task = session.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let results = myJson["results"] as! [NSMutableDictionary]
                        self.markets = results
                        self.makePins()
                    }
                    catch
                    {
                        print("json error")
                    }
                }
          
            }
        })
        task.resume()
    }
    
    func makePins(){
//        print("making pins!")
        //            print(self.markets)
        let queue = DispatchQueue(label: "com.groovygrow.queue")
        queue.sync{
            for i in 0..<self.markets.count {
                let currentMarketID = self.markets[i]["id"]!
                //                    print("Ⓜ️", i, currentMarketID)
                let url = URL(string: "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id=\(currentMarketID)")
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let task = session.dataTask(with: url!, completionHandler: {
                    (data, response, error) in
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as Optional {
                            let results = jsonResult as! NSMutableDictionary
                            let marketDetails = results["marketdetails"] as! NSMutableDictionary
                            self.markets[i]["address"] = marketDetails["Address"]
                            let currentAddressString = marketDetails["Address"] as! String
//                            print(currentAddressString)
                            self.markets[i]["link"] = marketDetails["GoogleLink"]
                            //let regexp: NSRegularExpression = "^q=(-?\d*).(\d*)%2C%20(-?\d*).(\d*)\%"
                            self.markets[i]["schedule"] = marketDetails["Schedule"]
                            self.markets[i]["products"] = marketDetails["Products"]
                            let geoCoder = CLGeocoder()
                            geoCoder.geocodeAddressString(currentAddressString, completionHandler:
                                { (placemarks, error) -> Void in
                                    if error != nil {
                                        print(error!)
                                        return
                                    }
                                    if placemarks!.count > 0 {
                                        let placemark = placemarks?[0]
                                        let location = placemark?.location
                            
                                        let lat = (location?.coordinate.latitude)! as Double
                                        self.markets[i]["latitude"] = lat
                                        
                                        let lng = (location?.coordinate.longitude)! as Double
                                        self.markets[i]["longitude"] = lng
                                        
                                        let currentMarketCoords:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
                                        let currentMarket = self.markets[i]
//                                        print(i, " : ", currentMarket)
                                        let titleString = currentMarket.value(forKey: "marketname") as! String
                                        let subtitleString = currentMarket.value(forKey: "address") as! String
                                        let pin = Annotation(title:titleString, subtitle: subtitleString, coordinate: currentMarketCoords)
                                        self.mapView.addAnnotation(pin)
                                    }
//                                    print(self.markets)
                            })
                        }
                    }
                    catch {
                        print("json error")
                    }
                })
                task.resume()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        
//        //1. Create the alert controller.
//        let alert = UIAlertController(title: "Location", message: "Enter Address", preferredStyle: .alert)
//        
//        //2. Add the text field. You can configure it however you need.
//        alert.addTextField { (textField) in
//            textField.text = "Address"
//        }
//        
//        // 3. Grab the value from the text field, and print it when the user clicks OK.
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            print("Text field: \(textField!.text)")
//            
//        }))
//        
//        // 4. Present the alert.
//        self.present(alert, animated: true, completion: nil)
        
        if (manager.location != nil){
            let userLat = manager.location!.coordinate.latitude
            let userLng = manager.location!.coordinate.longitude
            let userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLat, userLng)
            let distanceSpan:CLLocationDegrees = 42000
            let region = MKCoordinateRegionMakeWithDistance(userLocation,distanceSpan, distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
            getMarkets(lat: userLat, lng: userLng)
        }
    }
    
    @IBAction func toMainView(_ segue: UIStoryboardSegue){
//        print("Map button pressed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
