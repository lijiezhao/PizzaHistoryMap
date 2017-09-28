//
//  ViewController.swift
//  myPizzaHistoryMap
//
//  Created by Lijie Zhao on 9/26/17.
//  Copyright © 2017 Lijie Zhao. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    /* --- Coordinate information -----
     Lat,long
     Naples: 40.8367321,14.2468856
     New York: 40.7216294 , -73.995453
     Chicago: 41.892479 , -87.6267592
     Chatham: 42.4056555,-82.1860369
     Beverly Hills: 34.0674607,-118.3977309
     
     -->Challenges!!<----
     208 S. Beverly Drive Beverly Hills CA:34.0647691,-118.3991328
     2121 N. Clark St Chicago IL: 41.9206921,-87.6375361
     
     For region monitoring:
     latitude: 37.33454235, longitude: -122.03666775000001
     --- */

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMapRegion(rangeSpan: 100)
    }

    //Propertieis and outlets
    var coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
    var camera = MKMapCamera()
    var pitch = 0
    var isOn = false
    
    //Outlets
    @IBOutlet weak var changePitch: UIButton!
    @IBOutlet weak var changeMapType: UIButton!
    @IBOutlet weak var MapView: MKMapView!
    
    //Actions
    @IBAction func changeMapType(_ sender: UIButton) {
        switch MapView.mapType{
        case.standard:
            MapView.mapType = .satellite
        case.satellite:
            MapView.mapType = .hybrid
        case.hybrid:
            MapView.mapType = .satelliteFlyover
        case.satelliteFlyover:
            MapView.mapType = .hybridFlyover
        case.hybridFlyover:
            MapView.mapType = .standard
        default:
            MapView.mapType = .standard
        }
    }
    
    @IBAction func changePitch(_ sender: UIButton) {
        pitch = (pitch + 15) % 90
        sender.setTitle("\(pitch)º", for: .normal)
        MapView.camera.pitch = CGFloat(pitch)
    }
    
    @IBAction func toggleMapFeatures(_ sender: UIButton) {
        //MapView.showsBuildings = isOn
        //isOn = !isOn
        isOn = !MapView.showsPointsOfInterest
        MapView.showsPointsOfInterest = isOn
        MapView.showsScale = isOn
        MapView.showsCompass = isOn
        MapView.showsTraffic = isOn
    }
    
    @IBAction func findHere(_ sender: UIButton) {
    }
    
    @IBAction func findPizza(_ sender: UIButton) {
    }
    
    @IBAction func locationPicker(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0: //Naples
            coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
        case 1: //New York
            coordinate2D = CLLocationCoordinate2DMake(40.7216294, -73.995453)
            updateMapCamera(heading: 245.0, altitude: 250)
            return
        case 2: //Chicago
            coordinate2D = CLLocationCoordinate2DMake(41.892479, -87.6267592)
            updateMapCamera(heading: 12.0, altitude: 50)
            return
        case 3: //Chatham
            coordinate2D = CLLocationCoordinate2DMake(42.4056555, -82.1860369)
            updateMapCamera(heading: 180, altitude: 1000)
        case 4: //Beverly Hills
            coordinate2D = CLLocationCoordinate2DMake(34.0674607, -118.3977309)
        default:
            coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
        }
        updateMapRegion(rangeSpan: 100)
    }
    
    
    //Instance Methods
    func updateMapRegion(rangeSpan:CLLocationDistance) {
        let region = MKCoordinateRegionMakeWithDistance(coordinate2D, rangeSpan, rangeSpan)
        MapView.region = region
    }
    
    func updateMapCamera(heading:CLLocationDirection, altitude:CLLocationDistance){
        camera.centerCoordinate = coordinate2D
        camera.heading = heading
        camera.altitude = altitude
        camera.pitch = 0.0
        changePitch.setTitle("0º", for: .normal)
        MapView.camera = camera
    }
}

