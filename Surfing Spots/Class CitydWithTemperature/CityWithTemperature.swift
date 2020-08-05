
class CitydWithTemperature: Comparable{
        
    var city: String
    var temperature: Int
    var cloudy: Bool
    
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
