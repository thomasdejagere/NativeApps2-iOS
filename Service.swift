import Foundation

class Service {
    //problemen met het gebruiken van een library dus hierdoor is het ophalen van de JSON mislukt
    enum Error: ErrorType
    {
        case MissingJsonProperty(name: String)
        case NetworkError(message: String?)
        case UnexpectedStatusCode(code: Int)
        case MissingData
        case InvalidJsonData
    }
    
    static let sharedService = Service()
    
    private let url: NSURL
    private let session: NSURLSession
    
    init() {
        let propertiesPath = NSBundle.mainBundle().pathForResource("properties", ofType: "plist")!
        let properties = NSDictionary(contentsOfFile: propertiesPath)!
        let baseUrl = properties["baseUrl"] as! String
        url = NSURL(string: baseUrl)!
        session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    }
    	
    func createFetchTask(completionHandler: (Result<[LoadPoint]>) -> Void) -> NSURLSessionTask {
        return session.dataTaskWithURL(url) {
            data, response, error in
            
            let completionHandler: Result<[LoadPoint]> -> Void = {
                result in
                dispatch_async(dispatch_get_main_queue()) {
                    //completionHandler($0)
                }
            }
            guard let response = response as? NSHTTPURLResponse else {
                completionHandler(.Failure(.NetworkError(message: error?.description)))
                return
            }
            guard response.statusCode == 200 else {
                completionHandler(.Failure(.UnexpectedStatusCode(code: response.statusCode)))
                return
            }
            guard let data = data else {
                completionHandler(.Failure(.MissingData))
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as! NSDictionary
                
                /*var strippedJson = json["Document"]["Folder"]["Placemark"].dictionaryValue
                
                
                guard let jsonParkingLots = json["Parkings"]?["parkings"] as? [NSDictionary] else {
                    completionHandler(.Failure(.MissingJsonProperty(name: "parkings")))
                    return
                }
                let lots = try jsonParkingLots.map { try LoadPoint(json: $0) }
                
                completionHandler(Result.Success(lots));*/
                
            } catch let error as NSError{
                completionHandler(.Failure(.InvalidJsonData))
            } catch let error as Error {
                completionHandler(.Failure(error))
            }
        }
}
}