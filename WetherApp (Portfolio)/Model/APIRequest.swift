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
            let temp = decodedData.main.temp
            return WeatherModel(temperature: temp ?? -273.15)
        } catch {
            print("Ошибка парсинга JSON: \(error)")
            return nil
        }
    }
}
