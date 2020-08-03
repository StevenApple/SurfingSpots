
class CitydWithTemperature: Comparable{
        
    let city: String
    let temperature: Int
    let cloudy: Bool
    
    init(city:String,temperature:Int,cloudy:Bool) {
        self.city = city
        self.temperature = temperature
        self.cloudy = cloudy
    }
    
    static func ==(lhs: CitydWithTemperature, rhs: CitydWithTemperature) -> Bool {
        return lhs.temperature == rhs.temperature
    }

    static func <(lhs: CitydWithTemperature, rhs: CitydWithTemperature) -> Bool {
        return lhs.temperature > rhs.temperature
    }


}
