//
//  RouteToClosestLoadPointController.swift
//  ChargeMeUp
//
//  Created by Thomas Dejagere on 15/01/16.
//  Copyright © 2016 Thomas Dejagere. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RouteToClosestLoadPointController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    
    var originalTopMargin: CGFloat!
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    var loadPointLocations: [LoadPoint] = []

    var closestLocation: CLLocation?
    var closestLoadPoint: LoadPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        //normaal staat deze code alleen wanneer de locatie van de user wordt opgevraagd. Maar omdat dit problemen geeft staat deze code nu hier
        fillLocationsArray()
        
        currentLocation = CLLocation(latitude: 51.0387879, longitude: 3.7335293)
        
        calculateClosestLoadPointToUser(loadPointLocations, closestToLocation: currentLocation!)
        
        print("Found closest location: \(closestLoadPoint!.location!)")
        //we receive the location from the emulator but because of some location errors in the emulator we are going to use a static location
        let center = CLLocationCoordinate2D(latitude: 51.0387879, longitude: 3.7335293)
        let visibleRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
        
        let secondAnnotation = CLLocationCoordinate2D(latitude: closestLoadPoint!.location!.coordinate.latitude, longitude: closestLoadPoint!.location!.coordinate.longitude)
        
        mapView.region = visibleRegion
        
        let closestLoadPointAnnotation = MKPointAnnotation()
        closestLoadPointAnnotation.coordinate = secondAnnotation
        closestLoadPointAnnotation.title = "\(closestLoadPoint!.eigenaar)"
        closestLoadPointAnnotation.subtitle = "\(closestLoadPoint!.aantal_beschikbaar)" + " are available"
        mapView.addAnnotation(closestLoadPointAnnotation)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Myself!"
        mapView.addAnnotation(annotation)
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            fillLocationsArray()
            
            print("Found user's location: \(location)")
            
            currentLocation = CLLocation(latitude: 51.0387879, longitude: 3.7335293)
            
            calculateClosestLoadPointToUser(loadPointLocations, closestToLocation: currentLocation!)

            
            print("Found closest location: \(closestLoadPoint!.location!)")
            //we receive the location from the emulator but because of some location errors in the emulator we are going to use a static location
            let center = CLLocationCoordinate2D(latitude: 51.0387879, longitude: 3.7335293)
            let visibleRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
            
            let secondAnnotation = CLLocationCoordinate2D(latitude: closestLoadPoint!.location!.coordinate.longitude, longitude: closestLoadPoint!.location!.coordinate.longitude)
            
            mapView.region = visibleRegion
            
            let closestLoadPointAnnotation = MKPointAnnotation()
            closestLoadPointAnnotation.coordinate = secondAnnotation
            closestLoadPointAnnotation.title = "\(closestLoadPoint!.eigenaar)"
            closestLoadPointAnnotation.subtitle = "\(closestLoadPoint!.aantal_beschikbaar)" + " are available"
            mapView.addAnnotation(closestLoadPointAnnotation)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "Myself!"
            mapView.addAnnotation(annotation)
            
            //calculateDirections(0, time: 0, routes: [])
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    

    func fillLocationsArray() {
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 1, location: Location(latitude: 51.049205022076, longitude: 3.70777306426007)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0493283894632, longitude: 3.70729349057797)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 3, location: Location(latitude: 51.0535873986523, longitude: 3.71851284099447)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0535873986523, longitude: 3.71851284099447)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0515833054301, longitude: 3.73131396512181)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0417625983028, longitude: 3.72575680098206)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0473571413691, longitude: 3.72794392182306)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0470468542373, longitude: 3.72791798040334)))
        self.loadPointLocations.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.1197163161912, longitude: 3.77541978657061)))
    }
    
    func calculateClosestLoadPointToUser(locations: [LoadPoint], closestToLocation location: CLLocation){
    
        var smallestDistance: CLLocationDistance?
        for loc in locations {
            let distance = location.distanceFromLocation(loc.location!)
            if smallestDistance == nil || distance < smallestDistance {
                closestLoadPoint = loc
                smallestDistance = distance
             }
        }
    }
    
    //implementatie voor de route van de locatie van de user naar de locatie van de dichtsbijzijnde laadpaal te verzorgen
    //jammergenoeg krijg ik die niet werkende
    //source: http://www.raywenderlich.com/87008/overlay-views-mapkit-swift-tutorial
    func calculateDirections(index: Int, var time: NSTimeInterval, var routes: [MKRoute]) {
        let destinationLocation = closestLocation
        let currentLocationMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentLocation!.coordinate.latitude, currentLocation!.coordinate.longitude), addressDictionary: nil)
        let destinationLocationMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(destinationLocation!.coordinate.latitude, destinationLocation!.coordinate.longitude), addressDictionary: nil)
        
        let request: MKDirectionsRequest = MKDirectionsRequest()
        request.source = MKMapItem(placemark: currentLocationMark)
        request.destination = MKMapItem(placemark: destinationLocationMark)
        
        
    }
    func showRoutes(routes: [MKRoute]) {
        for i in 0..<routes.count {
            plotPolyLine(routes[i])
        }
    }

    func plotPolyLine(route: MKRoute) {
        mapView.addOverlay(route.polyline)
        if mapView.overlays.count == 1 {
            mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0),
                animated: false)
        }
        else {
            let polylineBoundingRect =  MKMapRectUnion(mapView.visibleMapRect,
                route.polyline.boundingMapRect)
            mapView.setVisibleMapRect(polylineBoundingRect,
                edgePadding: UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0),
                animated: false)
        }
    }

    
}
extension RouteToClosestLoadPointController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        if (overlay is MKPolyline) {
            if mapView.overlays.count == 1 {
                polylineRenderer.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.75)
            } else {
                polylineRenderer.strokeColor = UIColor.greenColor().colorWithAlphaComponent(0.75)
            }
            polylineRenderer.lineWidth = 5
        }
        return polylineRenderer
    }
}



