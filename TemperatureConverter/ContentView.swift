//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Nyan Min Htet on 30/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0
    @State private var inputUnit = "Fahrenheit"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var textFieldIsFocused: Bool
    
    let units = ["Celsius": UnitTemperature.celsius, "Fahrenheit": UnitTemperature.fahrenheit, "Kelvin": UnitTemperature.kelvin]
    
    var result: Double {
        guard
            let inputUnit = units[inputUnit],
            let outputUnit = units[outputUnit]
        else { return 0 }
        
        let input = Measurement(value: inputValue, unit: inputUnit)
        let output = input.converted(to: outputUnit)
        
        return output.value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(Array(units.keys), id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Unit")
                }
                Section {
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(Array(units.keys), id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output Unit")
                }
                Section {
                    TextField("Input Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($textFieldIsFocused)
                } header: {
                    Text("Input Value")
                }
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Output value")
                }
            }
            .navigationTitle("Uniti Conversio")
            .toolbar {
                Button("Done") {
                    textFieldIsFocused = false
                }
            }
        }
    }
}
