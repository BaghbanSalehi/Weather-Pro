//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class WeatherDataModel {
    var temperature = 0
    var condition = 0
    var city = ""
    var weatherIconName = ""
    var sunriseCode = 0
    var sunrise = ""
    var sunsetCode = 0
    var sunset = ""
   // var time = ""
    //var sunrise = ""
    //Declare your model variables here
    
    
    //This method turns a condition code into the name of the weather condition image
    
   func updateWeatherIcon(condition: Int) -> String {

    switch (condition) {

        case 0...300 :
            return "Thunderstorm"//ina esme picture haye abo havahaye mokhtalefan

        case 301...500 :
            return "Light rain"

        case 501...599 :
            return "Shower"

        case 600...601, 611...619 :
            return "Snow"
        
        case 701...740, 742...771 :
            return "Mist"
        
        case 741 :
            return "Fog"
        
        case 772...799 :
            return "Heavystorm"

        case 800 :
            return "Sunny"

        case 801...803 :
            return "Cloudy"
        
       case 804 :
        return "Overcast"

        case 900...903, 905...1000  :
            return "Heavystorm"
        
        case 903, 602, 620...622 :
            return "Heavysnow"
        
        case 904 :
            return "Sunny"

        default :
            return "dunno"
        }

    }
}
