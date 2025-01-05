//
//  MathGameApp.swift
//  MathGame
//
//  Created by Aidan Bergerson on 12/14/24.
//

import SwiftUI

@main
struct MathGameApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
