
import UIKit

class TableViewController: UITableViewController,NetworkDownloadProtocols {

    var listOfCity = [CitydWithTemperature]()
    var previousListOfCity = [CitydWithTemperature]()
    var randomNumbers = [Int]()
   


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.configNavigationBarAppearance()
        self.downloadTheListOfCity{ success in
            
            if (success){
                print("Timer fired")
                _ =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.updateRandomlyEveryThreeSecondsTheTemperature), userInfo: nil, repeats: true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.listOfCity.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : TableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell
        
        if (cell == nil){
            
            let nib : [TableViewCell] = Bundle.main.loadNibNamed("Cell", owner: self, options: nil) as! [TableViewCell]
            cell = nib[0]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        }
        cell.cityLabel.text = self.listOfCity[indexPath.row].city
        print("The city name on cell \(String(describing: cell.cityLabel.text)) and temp \(self.listOfCity[indexPath.row].temperature)")
        
        if (self.listOfCity[indexPath.row].cloudy){
            cell.temperatureLabel.text = "Cloudy" + " - " + String(self.listOfCity[indexPath.row].temperature) + " " + "degrees"
            cell.cloudyView.backgroundColor = UIColor.darkGray
            cell.cloudyView.makeTheViewCornersRounded(targetView: cell.cloudyView)

        } else {
            cell.temperatureLabel.text = "Sunny" + " - " + String(self.listOfCity[indexPath.row].temperature) + " " + "degrees"
            cell.img.image = UIImage(named: self.listOfCity[indexPath.row].city)?.makeCornersRounded(radius: 20)
            
        }
        return cell
    }
 
  
}
