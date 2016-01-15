import UIKit
import MapKit

class LoadPointViewController: UITableViewController{
    @IBOutlet weak var typeVehicle: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var aantal_beschikbaar: UILabel!
    @IBOutlet weak var betaal_systeem: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    
    var loadPoint : LoadPoint!
    
    override func viewDidLoad() {
        self.title = "\(loadPoint.eigenaar)"
        typeVehicle.text = "\(loadPoint.type_voert)"
        owner.text = "\(loadPoint.eigenaar)"
        aantal_beschikbaar.text = "\(loadPoint.aantal_beschikbaar)"
        betaal_systeem.text = "\(loadPoint.betaalsyst)"
        
        let center = CLLocationCoordinate2D(latitude: loadPoint.location!.coordinate.latitude, longitude: loadPoint.location!.coordinate.longitude)
        let visibleRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.region = visibleRegion
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        
    }
    
    @IBAction func openUrl() {
        
    }
}