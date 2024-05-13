//
//  NetworkService.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 13/05/2024.
//

import Foundation
protocol NetworkApiServices{
    func fetchLocationWeatherConditions(completionHandler: @escaping (WeatherData?)->Void)
}

class NetworkService : NetworkApiServices{
    
     func fetchLocationWeatherConditions(completionHandler: @escaping (WeatherData?)->Void) {
        let locationWeatherConditionsURL = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=57d0921d2ce54c4496c75056241205&q=30.0715495,31.02")
        
        guard let url = locationWeatherConditionsURL else{
            return
        }
        let urlRequest = URLRequest(url: url)
        let urlSesion = URLSession(configuration: .default)
        let task = urlSesion.dataTask(with: urlRequest){data, response, error in
            
            guard let data = data else {
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try jsonDecoder.decode(WeatherData.self, from: data)
                completionHandler(result)
            }
            catch{
                
                completionHandler(nil)
                
            }
        }
        task.resume()
        
    }
}
