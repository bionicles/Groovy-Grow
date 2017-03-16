//  annotation.swift
//  Groovy Grow
//
//  Created by Bion Howard on 3/16/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    var title:String?
    var subtitle:String?
    var coordinate:CLLocationCoordinate2D
    
    var mapPinDescription: String{
        return "\(title): \(subtitle)"
    }
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D){
        self.title=title
        self.subtitle=subtitle
        self.coordinate = coordinate
    }
}

