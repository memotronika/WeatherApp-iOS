//
//  WeatherData.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 11/03/2025.
//

import Foundation

struct WeatherData: Codable {
    let main: Main!
}

struct Main: Codable {
    let temp: Double!
}
