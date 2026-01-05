//
//  URLBuilder.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import Foundation

/// Protocol defining a URL builder
/// Respects the Interface Segregation principle: specific and targeted interface
protocol URLBuilder {
    func buildURL(with parameters: URLParameters) -> String
}
