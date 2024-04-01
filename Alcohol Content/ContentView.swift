//
//  ContentView.swift
//  Alcohol Content
//
//  Created by sq022 on 4/1/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var bacInput: String = ""
    @State private var latestBAC: Double = 0.0
    @ObservedObject private var healthStore = HealthStore()

    var body: some View {
        VStack {
            TextField("Enter your BAC", text: $bacInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            Button("Submit BAC") {
                if let bacValue = Double(bacInput) {
                    healthStore.addBACData(bacValue: bacValue)
                    latestBAC = bacValue
                    bacInput = ""
                }
            }
            .padding()

            Text("Latest BAC: \(latestBAC, specifier: "%.3f")")
                .padding()
        }
        .onAppear {
            healthStore.getLatestBAC { result in
                latestBAC = result
            }
        }
    }
}

#Preview {
    ContentView()
}
