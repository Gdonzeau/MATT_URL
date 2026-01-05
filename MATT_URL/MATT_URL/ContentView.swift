//
//  ContentView.swift
//  MATT_URL
//
//  Created by Guillaume on 05/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DeepLinkViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                // Section Full Image
                Section("Image Parameters") {
                    Toggle("Full Image", isOn: $viewModel.fullImage)
                        .onChange(of: viewModel.fullImage) { _, _ in
                            viewModel.generateURL()
                        }
                    
                    Picker("Number of Images", selection: $viewModel.selectedNbImage) {
                        ForEach(viewModel.availableNbImageOptions, id: \.self) { option in
                            Text("\(option)").tag(option)
                        }
                    }
                    .onChange(of: viewModel.selectedNbImage) { _, _ in
                        viewModel.generateURL()
                    }
                }
                
                // Section Colors
                Section("Colors") {
                    ColorPickerRow(
                        title: "Color 1",
                        selectedColor: $viewModel.selectedColor1,
                        availableColors: viewModel.availableColors
                    ) {
                        viewModel.generateURL()
                    }
                    
                    ColorPickerRow(
                        title: "Color 2",
                        selectedColor: $viewModel.selectedColor2,
                        availableColors: viewModel.availableColors
                    ) {
                        viewModel.generateURL()
                    }
                    
                    ColorPickerRow(
                        title: "Color 3",
                        selectedColor: $viewModel.selectedColor3,
                        availableColors: viewModel.availableColors
                    ) {
                        viewModel.generateURL()
                    }
                    
                    ColorPickerRow(
                        title: "Color 4",
                        selectedColor: $viewModel.selectedColor4,
                        availableColors: viewModel.availableColors
                    ) {
                        viewModel.generateURL()
                    }
                }
                
                // Section Date and Time
                Section("Date and Time") {
                    DatePicker(
                        "Date",
                        selection: $viewModel.selectedDate,
                        displayedComponents: .date
                    )
                    .onChange(of: viewModel.selectedDate) { _, _ in
                        viewModel.generateURL()
                    }
                    
                    DatePicker(
                        "Time",
                        selection: $viewModel.selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .onChange(of: viewModel.selectedTime) { _, _ in
                        viewModel.generateURL()
                    }
                }
                
                // Section Generated URL
                Section("Generated URL") {
                    Text(viewModel.generatedURL)
                        .font(.system(.caption, design: .monospaced))
                        .textSelection(.enabled)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        viewModel.openURL()
                    }) {
                        HStack {
                            Image(systemName: "safari")
                            Text("Open in Browser")
                        }
                    }
                    .disabled(viewModel.generatedURL.isEmpty)
                }
            }
            .navigationTitle("Deep Link Builder")
        }
    }
}

/// Reusable component for selecting a color
struct ColorPickerRow: View {
    let title: String
    @Binding var selectedColor: ColorHex?
    let availableColors: [ColorHex]
    let onSelectionChange: () -> Void
    
    var body: some View {
        Picker(title, selection: $selectedColor) {
            Text("Aucune").tag(nil as ColorHex?)
            ForEach(availableColors) { color in
                HStack {
                    Circle()
                        .fill(color.color)
                        .frame(width: 20, height: 20)
                    Text(color.displayName)
                }
                .tag(color as ColorHex?)
            }
        }
        .onChange(of: selectedColor) { _, _ in
            onSelectionChange()
        }
    }
}

#Preview {
    ContentView()
}
