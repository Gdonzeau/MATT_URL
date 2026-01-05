//
//  DeepLinkViewModel.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import Foundation
import Combine
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// ViewModel to manage business logic for deep link URL construction
/// Respects the Dependency Inversion principle: depends on protocols, not concrete implementations
class DeepLinkViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var fullImage: Bool = false
    @Published var selectedNbImage: Int = ImageCountConfiguration.defaultValue
    @Published var selectedColor1: ColorHex?
    @Published var selectedColor2: ColorHex?
    @Published var selectedColor3: ColorHex?
    @Published var selectedColor4: ColorHex?
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: Date = Date()
    
    @Published var generatedURL: String = ""
    
    // MARK: - Dependencies
    
    private let colorProvider: ColorProvider
    private let urlBuilder: URLBuilder
    
    // MARK: - Computed Properties
    
    var availableColors: [ColorHex] {
        colorProvider.getAvailableColors()
    }
    
    var availableNbImageOptions: [Int] {
        ImageCountConfiguration.availableOptions
    }
    
    // MARK: - Initialization
    
    /// Dependency injection to respect the Dependency Inversion principle
    init(colorProvider: ColorProvider = DefaultColorProvider(),
         urlBuilder: URLBuilder = DeepLinkURLBuilder()) {
        self.colorProvider = colorProvider
        self.urlBuilder = urlBuilder
        
        // Initialize with the first available colors
        let colors = colorProvider.getAvailableColors()
        if colors.count >= 4 {
            selectedColor1 = colors[0]
            selectedColor2 = colors[1]
            selectedColor3 = colors[2]
            selectedColor4 = colors[3]
        }
        
        generateURL()
    }
    
    // MARK: - Methods
    
    /// Generates the deep link URL with current parameters
    func generateURL() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HHmm"
        let timeString = timeFormatter.string(from: selectedTime)
        
        let parameters = URLParameters(
            fullImage: fullImage,
            nbImage: selectedNbImage,
            color1: selectedColor1?.hexCode ?? "",
            color2: selectedColor2?.hexCode ?? "",
            color3: selectedColor3?.hexCode ?? "",
            color4: selectedColor4?.hexCode ?? "",
            time: timeString,
            date: dateString
        )
        
        generatedURL = urlBuilder.buildURL(with: parameters)
        print("URL = \(generatedURL)")
    }
    
    /// Opens the URL in the default browser
    func openURL() {
        guard let url = URL(string: generatedURL) else { return }
        #if os(iOS)
        UIApplication.shared.open(url)
        #elseif os(macOS)
        NSWorkspace.shared.open(url)
        #endif
    }
}
