//
//  ContentView.swift
//  Degree Converter
//
//  Created by Dokx Dig on 18.08.23.
//

import SwiftUI

enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var inputUnitIndex = 0
    @State private var outputUnitIndex = 1
    @State private var inputValue = ""
    @State private var outputValue = ""
    @FocusState private var amountisFocused: Bool

    private var inputUnit: TemperatureUnit {
        return TemperatureUnit.allCases[inputUnitIndex]
    }

    private var outputUnit: TemperatureUnit {
        return TemperatureUnit.allCases[outputUnitIndex]
    }

    private var convertedValue: Double {
        guard let inputValue = Double(inputValue) else {
            return 0
        }

        var result: Double

        switch inputUnit {
        case .celsius:
            switch outputUnit {
            case .celsius:
                result = inputValue
            case .fahrenheit:
                result = inputValue * 9/5 + 32
            case .kelvin:
                result = inputValue + 273.15
            }
        case .fahrenheit:
            switch outputUnit {
            case .celsius:
                result = (inputValue - 32) * 5/9
            case .fahrenheit:
                result = inputValue
            case .kelvin:
                result = (inputValue - 32) * 5/9 + 273.15
            }
        case .kelvin:
            switch outputUnit {
            case .celsius:
                result = inputValue - 273.15
            case .fahrenheit:
                result = (inputValue - 273.15) * 9/5 + 32
            case .kelvin:
                result = inputValue
            }
        }

        return result
    }

    var body: some View {
        Form {
            
            Section {
                Text("Temperature Converter")
                    .font(.title)
                    .padding()
                Picker("Input Unit", selection: $inputUnitIndex) {
                    ForEach(0..<TemperatureUnit.allCases.count, id: \.self) {
                        Text(TemperatureUnit.allCases[$0].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            TextField("Enter Value", text: $inputValue)
                .keyboardType(.decimalPad)
                .focused($amountisFocused)
                .textFieldStyle(.roundedBorder)
            
            
            Section {
                Picker("Output Unit", selection: $outputUnitIndex) {
                    ForEach(0..<TemperatureUnit.allCases.count, id: \.self) {
                        Text(TemperatureUnit.allCases[$0].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Text(" \(convertedValue, specifier: "%.2f") \(outputUnit.rawValue)")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountisFocused = false
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
