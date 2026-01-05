//
//  DefaultColorProvider.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import Foundation

/// Default implementation of ColorProvider
/// Respects the Single Responsibility principle: single responsibility (providing colors)
/// Uses the ColorHex enum to simplify adding new colors
class DefaultColorProvider: ColorProvider {
    
    /// Returns all available colors from the enum
    /// To add a new color, simply add a case to the ColorHex enum
    func getAvailableColors() -> [ColorHex] {
        return ColorHex.allCases
    }
}
