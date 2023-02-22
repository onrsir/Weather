//
//  WeatherRoot.swift
//  Hava Durumu
//
//  Created by Onur Sir on 14.02.2023.
//
import Foundation

struct Weather: Codable {
    
    // MARK: - Properties
    var cityName: String
    var data: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case data = "data"
    }
}
