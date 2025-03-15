//
//  WeatherData.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 11/03/2025.
//

import Foundation


struct WeatherData: Codable {
    let name: String
    let main: WeatherModel.Main
    let sys: WeatherModel.Sys
    let wind: WeatherModel.Wind
    let coord: WeatherModel.Coord
    let weather: [WeatherModel.Weather]
    let visibility: Int
    let clouds: WeatherModel.Clouds
    let dt: Int
    let timezone: Int
    let id: Int
    let cod: Int
}
