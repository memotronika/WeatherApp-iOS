//
//  apiRequest.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 11/03/2025.
//


import Foundation

struct APIRequest {
    
    func performRequest(city:String = "London", completion: @escaping (WeatherModel?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=\(city)&appid=\(Key.getApiKey())"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let safeData = data {
                let weather = self.parseJSON(safeData)
                completion(weather) 
            }
        }
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            return WeatherModel(
                city: decodedData.name,
                temp: decodedData.main.temp,
                humidity: decodedData.main.humidity,
                pressure: decodedData.main.pressure,
                sunrise: decodedData.sys.sunrise,
                sunset: decodedData.sys.sunset,
                windSpeed: decodedData.wind.speed,
                windDirection: decodedData.wind.deg,
                main: decodedData.main,
                sys: decodedData.sys,
                wind: decodedData.wind,
                coord: decodedData.coord,
                weather: decodedData.weather,
                clouds: decodedData.clouds,
                dt: decodedData.dt,
                timezone: decodedData.timezone,
                id: decodedData.id,
                cod: decodedData.cod
            )
        } catch {
            print("Json error: \(error)")
            return nil
        }
    }
    }

