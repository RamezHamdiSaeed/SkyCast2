//
//  LocationResponse.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 13/05/2024.
//

import Foundation

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct Current: Codable {
    let lastUpdated: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let pressureMb: Int
    let humidity: Int
    let feelslikeC: Double
    let visKm: Int
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
    let moonIllumination: Int
    let isMoonUp: Int
    let isSunUp: Int
}

struct Hour: Codable {
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let pressureMb: Int
    let humidity: Int
    let feelslikeC: Double
    let visKm: Int
}

struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
}

struct ForecastDay: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct WeatherData: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}
