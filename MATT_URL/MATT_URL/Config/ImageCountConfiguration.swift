//
//  ImageCountConfiguration.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import Foundation

/// Configuration for image count options
/// Respects the Open/Closed principle: easily modifiable without changing the rest of the code
struct ImageCountConfiguration {
    /// Available options for image count
    /// Easily modifiable to add/remove options
    static let availableOptions: [Int] = [1, 2, 3]
    
    /// Default value
    static let defaultValue: Int = 1
}
