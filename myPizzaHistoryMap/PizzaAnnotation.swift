//
//  PizzaAnnotation.swift
//  myPizzaHistoryMap
//
//  Created by Lijie Zhao on 9/28/17.
//  Copyright © 2017 Lijie Zhao. All rights reserved.
//

import UIKit
import MapKit

class PizzaAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate:CLLocationCoordinate2D, title:String?, subtitle:String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
