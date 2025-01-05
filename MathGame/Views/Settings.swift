//
//  Settings.swift
//  MathGame
//
//  Created by Aidan Bergerson on 12/16/24.
//

import SwiftUI

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case moderate = "Moderate"
    case hard = "Hard"
}


struct Settings: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("difficultyLevel") private var difficultyMode: Difficulty = .moderate
    
    
    var body: some View {
        NavigationView {
            Form {
                Section("App Settings") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    Picker("Diffculty Level", selection: $difficultyMode) {
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Text(difficulty.rawValue)
                        }
                    }
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
