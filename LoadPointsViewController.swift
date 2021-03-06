import UIKit

class LoadPointsViewController: UITableViewController
{
    var loadPoints = [LoadPoint]()
    var filteredLoadPoints = [LoadPoint]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //function needed for the searchResults
    override func viewDidLoad() {
        self.title = "Loadpoints"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = VehicleType.allValues
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredLoadPoints = loadPoints.filter { loadPoint in
            let categoryMatch = (scope == "All") || (loadPoint.type_voert == VehicleType(rawValue: scope))
            let result = categoryMatch && loadPoint.eigenaar.lowercaseString.containsString(searchText.lowercaseString)
            return result
        }
        tableView.reloadData()
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredLoadPoints.count
        }
        return loadPoints.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        //let loadPoint = self.loadPoints[indexPath.row]
        //cell.textLabel!.text = "\(loadPoint.eigenaar)"
        //return cell
        let loadPoint: LoadPoint
        if searchController.active && searchController.searchBar.text != "" {
            loadPoint = filteredLoadPoints[indexPath.row]
        } else {
            loadPoint = loadPoints[indexPath.row]
        }
        cell.textLabel?.text = "\(loadPoint.eigenaar)"
        if(loadPoint.aantal_beschikbaar == 0) {
            cell.detailTextLabel?.text = "full"
        } else {
            cell.detailTextLabel?.text = "\(loadPoint.aantal_beschikbaar)" + " free places"
        }
        
        return cell
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 1, location: Location(latitude: 51.049205022076, longitude: 3.70777306426007)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0493283894632, longitude: 3.70729349057797)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.bike, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 3, location: Location(latitude: 51.0535873986523, longitude: 3.71851284099447)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0535873986523, longitude: 3.71851284099447)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.bike, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0515833054301, longitude: 3.73131396512181)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0417625983028, longitude: 3.72575680098206)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.bike, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0473571413691, longitude: 3.72794392182306)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.0470468542373, longitude: 3.72791798040334)))
        self.loadPoints.append(LoadPoint(fid: 2, id: 2, type_voert: VehicleType.car, exploitant: "Blue Corner", eigenaar: "Blue Corner", vanaf: "2015", betaalsyst: "sms_betalen", aantal_beschikbaar: 2, location: Location(latitude: 51.1197163161912, longitude: 3.77541978657061)))
        
    }
    
    @IBAction func sortList(){
        loadPoints.sortInPlace({
            $0.aantal_beschikbaar > $1.aantal_beschikbaar
        })
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detail = (segue.destinationViewController as! UINavigationController).topViewController as! LoadPointViewController
        let selectedLoadPoint: LoadPoint
        if searchController.active && searchController.searchBar.text != "" {
            selectedLoadPoint = filteredLoadPoints[tableView.indexPathForSelectedRow!.row]
        } else {
            selectedLoadPoint = loadPoints[tableView.indexPathForSelectedRow!.row]
        }
        detail.loadPoint = selectedLoadPoint
    }
    
    
}
extension LoadPointsViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension LoadPointsViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}