//
//  DeepLinkURLBuilder.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import Foundation

/// Implementation of URL builder for deep links
/// Respects the Single Responsibility principle: single responsibility (building the URL)
class DeepLinkURLBuilder: URLBuilder {
    
    private let baseURL = "https://gdtr.fr/colormatch/save"
    
    func buildURL(with parameters: URLParameters) -> String {
        var components = URLComponents(string: baseURL)
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "fullImage", value: String(parameters.fullImage)))
        queryItems.append(URLQueryItem(name: "nbImage", value: String(parameters.nbImage)))
        queryItems.append(URLQueryItem(name: "color1", value: parameters.color1))
        queryItems.append(URLQueryItem(name: "color2", value: parameters.color2))
        queryItems.append(URLQueryItem(name: "color3", value: parameters.color3))
        queryItems.append(URLQueryItem(name: "color4", value: parameters.color4))
        queryItems.append(URLQueryItem(name: "time", value: parameters.time))
        queryItems.append(URLQueryItem(name: "date", value: parameters.date))
        
        components?.queryItems = queryItems
        
        return components?.url?.absoluteString ?? baseURL
    }
}
