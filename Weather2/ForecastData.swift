//
//  ForecastData.swift
//  Weather2
//
//  Created by Dima  on 02.08.2022.
//

import Foundation

struct ForecastData: Codable {
    var cod: String = ""
    var message: Int = 0
    var cnt: Int = 0
    var list: [List] = []
    var city: City = City()
}

 //MARK: - City
struct City: Codable {
    var id: Int = 0
    var name: String = ""
}

 //MARK: - List
struct List: Codable {
    var dt: Int = 0
    var main: MainClass = MainClass()
    //var weather: [Weather]
    var dt_txt: String = ""


}

// MARK: - MainClass
struct MainClass: Codable {
    var temp: Double = 0.0
}


 //MARK: - Weather
//struct WeatherF: Codable {
//    var id: Int = 0
//    var description: String = ""
//    var icon: String = ""
//
//}





//struct Forecast: Codable {
//    let cod: String
//    let message, cnt: Int
//    let list: [List]
//    let city: City
//}
//
//// MARK: - City
//struct City: Codable {
//    let id: Int
//    let name: String
//
//}
//

//
//// MARK: - List
//struct List: Codable {
//    let dt: Int
//    let main: MainClass
//    let weather: [WeatherF]
//    let clouds: Clouds
//    let wind: Wind
//    let visibility, pop: Int
//    let sys: Sys
//    let dtTxt: String
//
//    enum CodingKeys: String, CodingKey {
//        case dt, main, weather, clouds, wind, visibility, pop, sys
//        case dtTxt = "dt_txt"
//    }
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - MainClass
//struct MainClass: Codable {
//    let temp, feelsLike, tempMin, tempMax: Double
//    let pressure, seaLevel, grndLevel, humidity: Int
//    let tempKf: Double
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
//        case humidity
//        case tempKf = "temp_kf"
//    }
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let pod: Pod
//}
//
//enum Pod: String, Codable {
//    case d = "d"
//    case n = "n"
//}
//
//// MARK: - Weather
//struct WeatherF: Codable {
//    let id: Int
//    let main: MainEnum
//    let weatherDescription, icon: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
//}
//
//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int
//    let gust: Double
//}
//
