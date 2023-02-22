//
//  JSONService.swift
//  Hava Durumu
//
//  Created by Onur Sir on 14.02.2023.
//
import CoreLocation

/// API üzerinden gelen bilgileri çekmemizi sağlar.
class WeatherProvider {
    
    // MARK: - Properties
    private let apiKey = "c1373952f50d4d8a85c0dd4dee6a89ae"
    private let baseURL = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily")!
    private let jsonDecoder = JSONDecoder()
    
    // MARK: - Functions
    func getWeather(for location: CLLocationCoordinate2D, completion: @escaping (Weather?) -> Void) {
        let queries: [String : String] = [
            "lat": String(location.latitude),
            "lon": String(location.longitude),
            "lang": "tr",
            "key": apiKey
        ]
        let requestURL = baseURL.withQueries(queries)!
        
        URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            guard let weatherData = data else {
                completion(nil)
                return
            }
            do {
                let weather = try self.jsonDecoder.decode(Weather.self, from: weatherData)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch {
                completion(nil)
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
