//
//  UIStoryboard+Ext.swift
//  Hava Durumu
//
//  Created by Onur Sir on 16.02.2023.
//

import UIKit

extension URL {
    
    // MARK: - Functions
    func withQueries(_ queries: [String : String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        return components?.url
    }
}
