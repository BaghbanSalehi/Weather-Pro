


import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import Foundation

class WeatherViewController: UIViewController , CLLocationManagerDelegate , ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast"
    let APP_ID = "cef578ced77838aef7830898dcc81188"
    

    let locationManager = CLLocationManager()
    let weatherData = WeatherDataModel()
    let forecastData = ForecastDataModel()
    
    var arraySize = 0
    var check = true // true = c va false = f
    

    
    //ui link
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var SunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() //location ro az gps begir
        
        //TODO:Set up the location manager here.
    
        }
    @IBAction func fConverter(_ sender: UIButton)
    {
        if (check)
        {
            weatherData.temperature = Int(round(Double(weatherData.temperature * 9/5) + 32))
        updateUIWithWeatherData()
            for i in 0..<arraySize
            {
                forecastData.temperature[i] = Int(round(Double(forecastData.temperature[i] * 9/5) + 32))
                
                
            }
            check = false
        }
    }
    @IBAction func cConverter(_ sender: UIButton) {
        if(!check){
            
        
            weatherData.temperature = Int(round(Double(weatherData.temperature - 32) * 5/9))
        updateUIWithWeatherData()
            for i in 0..<arraySize
            {
                forecastData.temperature[i] = Int(round(Double(forecastData.temperature[i] - 32) * 5/9))
                
            }
            
            check = true
        }
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData (url : String , parameters : [String : String])
    {
        Alamofire.request(url , method : .get , parameters : parameters).responseJSON {
         response in
            if response.result.isSuccess
            {

                let weatherJson : JSON = JSON(response.result.value!)// meghdar gerefte shode az site ro mirizim dakhel moteghayer
               // print(weatherJson)
                self.updateWeatherData(json: weatherJson)
                
                
                
            }
            else
            {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
                
            }
            
        }
        
    }
    
    func getForecastData (url : String, parameters : [String : String])
    {
        Alamofire.request(url , method : .get , parameters : parameters).responseJSON {
            response in
            if response.result.isSuccess
            {
                
                let weatherJson : JSON = JSON(response.result.value!)// meghdar gerefte shode az site ro mirizim dakhel moteghayer
                //print(weatherJson)
                self.arraySize = weatherJson["list"].count
                self.updateForecastData(json: weatherJson)
                
                print(self.arraySize)
                
                
            }
            else
            {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
                
            }
            
        }
        
    }
    

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json : JSON)
    {
        if let weatherTemp = json ["main"]["temp"].double { // meghdar optional hast weathertemp baraye inke az ! safe estefade she az sakhtar if estefade kardim
            weatherData.temperature = Int(weatherTemp - 273.15) //tabdil dama az kelvin be c
            weatherData.city = json ["name"].stringValue
            weatherData.condition = json ["weather"][0]["id"].intValue
            weatherData.weatherIconName = weatherData.updateWeatherIcon(condition: weatherData.condition)
            weatherData.sunriseCode = json ["sys"]["sunrise"].intValue
            weatherData.sunsetCode = json ["sys"]["sunset"].intValue
            dateCalculate()
            
            
            updateUIWithWeatherData()

            
            }
        else
        {
            cityLabel.text = "Weather Unavailable try again later,if the problem exists contact app support"
        }
        
    }
    
    func updateForecastData(json : JSON)
    {
        for i in 0..<arraySize
        {
        if let weatherTemp = json ["list"][i]["main"]["temp"].double { // meghdar optional hast weathertemp baraye inke az ! safe estefade she az sakhtar if estefade kardim
            forecastData.temperature.append((Int(weatherTemp - 273.15))) //tabdil dama az kelvin be c
            forecastData.condition.append(json ["list"][i]["weather"][0]["id"].intValue)
            forecastData.weatherIconName.append(forecastData.updateWeatherIcon(condition: forecastData.condition[i]))
           
            let dateHelper = json ["list"][i]["dt_txt"].stringValue
            
            let date = dateFormat(formatDate : dateHelper)
            forecastData.time.append(date)
            
        }
        else
        {
            cityLabel.text = "Weather Unavailable try again later,if the problem exists contact app support"
        }
        }
    }
    
    /****************************************************************/
   func dateFormat(formatDate : String)->String // tabdil bando basat date be chizi ke mikhaym
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss" //formaty ke dar reshte alan darim
        guard let dateString = dateFormatter.date(from: formatDate) else {preconditionFailure("Wrong Input")} //tabdil tarikh az reshte be date
        dateFormatter.dateFormat = "EEE,MMM d, h a" //formaty ke mikhaym neshun bedim
        let date = dateFormatter.string(from: dateString) // tabdil tarikh az date be reshte bara namayesh
        return date
    }
    
    func dateCalculate() // tabdil code tarikh be formate adam izad
    {
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(weatherData.sunriseCode))//tabdil code tarikh be tarikh
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(weatherData.sunsetCode))
        let dateFormatter = DateFormatter() // be formatter niaz darim
        dateFormatter.timeStyle = .short // formaty ke mikhaym
        var finalDate = dateFormatter.string(from: sunriseDate) // tabdil tarikh az date be string
        weatherData.sunrise = finalDate
        finalDate = dateFormatter.string(from: sunsetDate)
        weatherData.sunset = finalDate
        
    }
   


    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData ()
    {
        cityLabel.text = weatherData.city
        temperatureLabel.text = "\(weatherData.temperature)°"
        weatherIcon.image = UIImage(named: weatherData.weatherIconName)
        weatherLabel.text = weatherData.weatherIconName
        SunriseLabel.text = "Sunrise: \(weatherData.sunrise)"
        sunsetLabel.text = "Sunset: \(weatherData.sunset)"
    
    }
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {  //location ro tahvil begir
        let location = locations [locations.count-1]  // akharin khune araye ro mikhaym
        if location.horizontalAccuracy > 0  //sehate dorost budane location ke bayad horizontal balaye 0 bashe
        {
         locationManager.stopUpdatingLocation() //age location bedast umade dorost bud amaliate gereftan location ro ghat kon
       //  locationManager.delegate=nil // jahate ghat kardan amaliat gereftane loc age dastor bala ba delay ejra she
        }
        let latitude = String(location.coordinate.latitude) // baraye inke location bedast amade ro vared template site weather konim
        let longitude = String(location.coordinate.longitude)
        let params : [String : String] = ["lat" : latitude , "lon" : longitude , "appid" : APP_ID] //sakhtar diffault site weather
        getWeatherData (url : WEATHER_URL , parameters : params)
        getForecastData (url: FORECAST_URL, parameters: params)
        
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String)
    {
        let params : [String : String] = ["q" : city , "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
        getForecastData(url: FORECAST_URL, parameters: params)
        
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "changeCityName"
        {
           let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
        else if segue.identifier == "foreCast"
        {
            let foreCastVC = segue.destination as! ForecastViewController

            foreCastVC.forecastData.temperature = forecastData.temperature
            foreCastVC.forecastData.condition = forecastData.condition
            
            foreCastVC.forecastData.time = forecastData.time
            foreCastVC.forecastData.weatherIconName = forecastData.weatherIconName
            foreCastVC.forecastData.check = check
            
        }
    }
    

    
    
}


