//
//  WeatherModel.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 11/03/2025.
//


struct WeatherModel: Codable {
    let city: String
    let temp: Double
    let humidity: Int
    let pressure: Int
    let sunrise: Int
    let sunset: Int
    let windSpeed: Double
    let windDirection: Int
    let main: Main
    let sys: Sys
    let wind: Wind
    let coord: Coord
    let weather: [Weather]
    let visibility: Int
    let clouds: Clouds
    let dt: Int
    let timezone: Int
    let id: Int
    let cod: Int

    struct Main: Codable {
        let temp: Double
        let humidity: Int
        let pressure: Int
    }

    struct Sys: Codable {
        let sunrise: Int
        let sunset: Int
        let country: String
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }

    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Clouds: Codable {
        let all: Int
    }
}
