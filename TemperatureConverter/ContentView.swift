//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Nyan Min Htet on 30/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0   // Initialize with one of the exact keys from your ordered list
    @State private var inputUnit = "Fahrenheit"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var textFieldIsFocused: Bool
    
    let units = ["Celsius": UnitTemperature.celsius, "Fahrenheit": UnitTemperature.fahrenheit, "Kelvin": UnitTemperature.kelvin]
    let orderedUnitKeys = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var result: Double {
        guard
            let currentInputUnit = units[inputUnit],
            let currentOutputUnit = units[outputUnit]
        else { return 0 }
        
        let input = Measurement(value: inputValue, unit: currentInputUnit)
        let output = input.converted(to: currentOutputUnit)
        
        return output.value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Section for Input Unit Picker
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(orderedUnitKeys, id: \.self) { unitKey in
                            Text(unitKey)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Unit Selection")
                }

                // Section for Input Value TextField
                Section {
                    TextField("Input Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($textFieldIsFocused)
                } header: {
                    Text("Enter Value to Convert")
                }

                // Section for Output Unit Picker
                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(orderedUnitKeys, id: \.self) { unitKey in
                            Text(unitKey)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output Unit Selection")
                }

                // Section for Displaying the Result
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Converted Value")
                }
            }
            .navigationTitle("Temp Conversion")
            .toolbar {
                if textFieldIsFocused {
                    Button("Done") {
                        textFieldIsFocused = false
                    }
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
