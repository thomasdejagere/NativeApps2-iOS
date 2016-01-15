//
//  ShowAllLoadPointsController.swift
//  ChargeMeUp
//
//  Created by Thomas Dejagere on 15/01/16.
//  Copyright © 2016 Thomas Dejagere. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShowAllLoadPointsController: UIViewController
{
    var loadPoints = [LoadPoint]()
    @IBOutlet weak var mapView: MKMapView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.loadPoints.append(LoadPoint(fid: 0, id: 0, type_voert: VehicleType.car, exploitant: "Wiebe Inc.", eigenaar: "Wiebe", vanaf: "2014", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.1197163161912, longitude: 3.77541978657061)))
        self.loadPoints.append(LoadPoint(fid: 1, id: 1, type_voert: VehicleType.bike, exploitant: "Thomas Inc.", eigenaar: "Thomas", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 5, location: Location(latitude: 51.0515833054301, longitude: 3.73131396512181)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Motion Inc.", eigenaar: "Blue Motion", vanaf: "2013", betaalsyst: "visa", aantal_beschikbaar: 0, location: Location(latitude: 51.0493283894632, longitude: 3.70729349057797)))
        
    }
    
    override func viewDidLoad() {
        self.title = "Loadpoints nearby"
        pointLoadPointsOnMap()
    }
    
    func pointLoadPointsOnMap() {
        //we receive the location from the emulator but because of some location errors in the emulator we are going to use a static location
        let center = CLLocationCoordinate2D(latitude: 51.0387879, longitude: 3.7335293)
        let visibleRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
        
        mapView.region = visibleRegion
        let annotation = MKPointAnnotation()
    
        annotation.coordinate = center
        annotation.title = "Myself!"
        mapView.addAnnotation(annotation)
        
        for loadPoint in loadPoints {
            let latitude = loadPoint.location!.coordinate.latitude
            let longitude = loadPoint.location!.coordinate.longitude
            let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            annotation.title = loadPoint.eigenaar
            annotation.subtitle = "\(loadPoint.aantal_beschikbaar)" + " free spaces"
            mapView.addAnnotation(annotation)
        }
        
    }
    
    

}
