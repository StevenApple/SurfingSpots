
import UIKit

protocol NetworkDownloadProtocols{
    func downloadTheListOfCity(from url: URL, completion:@escaping([CitydWithTemperature]) -> Void)
    func generateRandomNumberFromApiThenAssignRandomlyToTemperature(from url: URL,completion:@escaping(Int,Bool,Bool) -> Void)
}


extension NetworkDownloadProtocols {
    func downloadTheListOfCity(from url: URL, completion:@escaping([CitydWithTemperature]) -> Void) {
        let session = URLSession(configuration: .default)
        var listOfCitiedWithTemperature: Array = [CitydWithTemperature]()
        var cloudy = false
        DispatchQueue.global(qos: .background).async {
            print("In background")
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription ?? "Unknown error")
                }
                if let data = data{
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let cities = json["cities"] as? [[String:AnyObject]]{
                                
                                for cityName in cities{
                                  let temp = Int.random(in: 10..<60)
                                    if (temp < 30){
                                        cloudy = true
                                    } else {
                                        cloudy = false
                                    }
                                   
                                    listOfCitiedWithTemperature.append(CitydWithTemperature(city:cityName["name"] as! String, temperature: temp,cloudy: cloudy
                                    ))
                                }
                               
                                completion(listOfCitiedWithTemperature)
                            }
                        }
                    }catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                        completion([])
                    }
                }
                
            }.resume()
        }
    }
    
}

extension NetworkDownloadProtocols{
    
    func generateRandomNumberFromApiThenAssignRandomlyToTemperature(from url: URL, completion:@escaping(Int,Bool,Bool) -> Void){
        
        var cloudy = false
        
        let session = URLSession(configuration: .default)
        var request = URLRequest.init(url: url)
        request.addValue("application/json", forHTTPHeaderField:"Content-Type")
        request.httpMethod = "GET"
        request.timeoutInterval = 30.0
        
        DispatchQueue.global(qos: .background).async {
            print("In background")
            
            session.dataTask(with:request) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription ?? "Unknown error")
                }
                if let data = data{
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let temp = json["number"] as? Int{
                                print("What is temp \(temp)")
                                if (temp < 30){
                                    cloudy = true
                                } else {
                                    cloudy = false
                                }
      
                                completion(temp,cloudy,true)
                                
                   
                            } else {
                                print("Failed to unwrap number from json")
                            }

                        }
                    }catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                } else {
                    
                }
                
            }.resume()
        }
    }
    
    
}

