
import UIKit

protocol NetworkDownloadProtocols{
    func downloadTheListOfCity(from url: URL, completion:@escaping([CitydWithTemperature]) -> Void)
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
                               
                                completion(listOfCitiedWithTemperature.sorted())
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

