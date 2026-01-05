//
//  ColorProvider.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import Foundation

/// Protocol defining a color provider
/// Respects the Open/Closed principle: open for extension, closed for modification
protocol ColorProvider {
    /// Returns the list of available colors
    func getAvailableColors() -> [ColorHex]
}
