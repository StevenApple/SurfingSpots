
import UIKit

extension TableViewController{
    
    func generateRandomNumber(){
        var counter = 0
        while self.listOfCity.count > self.randomNumbers.count {
            counter += 1
            self.randomNumbers.append(counter - 1)
        } 
        print("What is random numbers \(self.randomNumbers)")
        
    }
    

    func downloadTheListOfCity(completion:@escaping(Bool) -> Void){
        downloadTheListOfCity(from: URL(string: UrlConfig.urlRunMocky)!) { listOfCityWithTemperature in
            self.listOfCity = listOfCityWithTemperature
            
            if (!self.listOfCity.isEmpty){
                self.generateRandomNumber()
                self.loadTheTableViewWithNewData { success in
                    if (success){
                        completion(true)
                    }
                }
         
                
            }
        }
    }
    
    
    func loadTheTableViewWithNewData(completion:@escaping(Bool) -> Void) {
        if #available(iOS 13, *) {
              DispatchQueue.main.async {
                self.listOfCity = self.listOfCity.sorted()
                var deletedIndexPaths = [IndexPath]()
                var insertedIndexPaths = [IndexPath]()
                let difference = self.listOfCity.difference(from: self.previousListOfCity)
               

                    for change in difference {
                        switch change {
                        case let .remove(offset, _, _):
                            deletedIndexPaths.append(IndexPath(row: offset, section: 0))
                        case let .insert(offset, _, _):
                            insertedIndexPaths.append(IndexPath(row: offset, section: 0))
                        }
                    }
               
                
                
                self.previousListOfCity = self.listOfCity

                self.tableView.performBatchUpdates({
                    self.tableView.deleteRows(at: deletedIndexPaths, with: .fade)
                    self.tableView.insertRows(at: insertedIndexPaths, with: .top)
                }, completion: { completed in
                    completion(true)
                    print("All done updating!")
                })
            
            }
        
        }
    }
    
    
    @objc func updateRandomlyEveryThreeSecondsTheTemperature(){
          if (self.listOfCity.isEmpty){
              return
          }

          // Generate array of numbers according to our rows availability in order to Generate Randomly numbers from array
          if (self.randomNumbers.isEmpty){
              self.generateRandomNumber()
          }
          
          print("What is the random numbers\(self.randomNumbers)")
          // Randomly choose index in order to update the cell in this case all cell will be update
          
          let index = randomNumbers.randomElement()
          let removeTheIndex = randomNumbers.firstIndex(of: index!)
          self.randomNumbers.remove(at: removeTheIndex!)
          let indexPath = IndexPath(row: index!, section: 0)
          
          self.generateRandomNumberFromApiThenAssignRandomlyToTemperature(from: URL(string: UrlConfig.numbersApi)!) {temp,cloudy,success in
              
              if (success){
                  self.listOfCity[index!].temperature = temp
                  self.listOfCity[index!].cloudy = cloudy
                  
                  DispatchQueue.main.async {
                      //  Reload the specific row
                      self.tableView.reloadRows(at: [indexPath], with: .right)
                      self.loadTheTableViewWithNewData{ success in}
                      
                  }

           
              }
          }
      }
      
}
