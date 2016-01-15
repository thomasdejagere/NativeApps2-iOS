import UIKit
import CoreLocation

enum VehicleType: String{
    case all = "All"
    case car = "Car"
    case bike = "Bike"
    
    static let allValues = [all.rawValue, car.rawValue, bike.rawValue]
}

class LoadPoint{
    let fid: Int
    let type_voert: VehicleType
    let exploitant: String
    let eigenaar: String
    let vanaf: String
    let betaalsyst: String
    let aantal_beschikbaar: Int
    var location: CLLocation?
    let description: String
    init(fid: Int, id: Int, type_voert: VehicleType, exploitant: String, eigenaar: String, vanaf: String, betaalsyst: String, aantal_beschikbaar: Int, location: Location) {
        self.fid = fid
        self.type_voert = type_voert
        self.exploitant = exploitant
        self.eigenaar = eigenaar
        self.vanaf = vanaf
        self.betaalsyst = betaalsyst
        self.aantal_beschikbaar = aantal_beschikbaar
        self.location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        self.description = eigenaar;
    }
    init(fid: Int, type_voert: VehicleType, exploitant: String, eigenaar: String, vanaf: String, betaalsyst: String, aantal: Int){
        self.fid = fid;
        self.type_voert = type_voert;
        self.exploitant = exploitant;
        self.eigenaar = eigenaar;
        self.vanaf = vanaf;
        self.betaalsyst = betaalsyst;
        self.aantal_beschikbaar = aantal;
        self.location = nil;
        self.description = eigenaar;
    }
    
}

//als een loadpoint wordt uitgeschreven zal de 'description' getoont worden
//er moet dus een field description zijn
extension LoadPoint: CustomStringConvertible { }

extension LoadPoint
{
    convenience init?(json: NSDictionary) throws {
        
        guard let fid = json["fid"] as? Int else {
            throw Service.Error.MissingJsonProperty(name: "description")
        }
        guard let type_voert = json["type_voert"] as? VehicleType else {
            throw Service.Error.MissingJsonProperty(name: "type_voert")
        }
        guard let exploitant = json["exploitant"] as? String else { throw Service.Error.MissingJsonProperty(name: "exploitant")
        }
        guard let eigenaar = json["eigenaar"] as? String else {
            throw Service.Error.MissingJsonProperty(name: "eigenaar")
        }
        guard let vanaf = json["beschikbaa"] as? String else {
            throw Service.Error.MissingJsonProperty(name: "beschikbaa")
        }
        guard let betaalsyst = json["betaalsyst"] as? String else {
            throw Service.Error.MissingJsonProperty(name: "betaalsyst")
        }
        guard let aantal_beschikbaar = json["aantal"] as? Int else { throw Service.Error.MissingJsonProperty(name: "aantal")
        }
        self.init(fid: fid, type_voert: type_voert, exploitant: exploitant, eigenaar: eigenaar, vanaf: vanaf, betaalsyst: betaalsyst, aantal: aantal_beschikbaar)
        
        
    }
}