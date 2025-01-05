//
//  ContentView.swift
//  MathGame
//
//  Created by Aidan Bergerson on 12/14/24.
//

import SwiftUI

// MARK: Different game modes for the game
enum GameModes: String, CaseIterable {
    case addition = "Addition"
    case subtract = "Subtraction"
    case multiply = "Multiplication"
    case division = "Division"
    case automatic = "Random"
    
    func performOperation(_ a: Int, _ b: Int) -> Int {
        switch self {
        case .addition:
            return a + b
        case .subtract:
            return a - b
        case .multiply:
            return a * b
        case .division:
            return a / b
        case .automatic:
            let modes: [GameModes] = GameModes.allCases.filter { $0 != .automatic }
            let randomMode = modes.randomElement() ?? .addition
            return randomMode.performOperation(a, b)
        }
    }
    
    var equationSigns: String {
        switch self {
        case .addition:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "x"
        case .division:
            return "÷"
        case .automatic:
            // Randomly select one of the non-automatic game modes
            let modes: [GameModes] = GameModes.allCases.filter { $0 != .automatic }
            return modes.randomElement()?.equationSigns ?? "+"
        }
    }
    
}

struct ContentView: View {
    var gameMode: GameModes = .automatic
    
    var body: some View {
        NavigationStack {
                VStack {
                    Spacer()
                    
                    GridComponent()
                    
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 10)
                .navigationTitle("QuickMath")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            Settings()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
    }
    // MARK: Custom Grid
    @ViewBuilder func GridComponent() -> some View {
        Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
            GridRow {
                NavigationLink {
                    MathGameMode(gameMode: .addition)
                        
                } label: {
                    gameModeButton(gameMode: .addition)
                }
                
                NavigationLink {
                    MathGameMode(gameMode: .subtract)
                } label: {
                    gameModeButton(gameMode: .subtract)
                }
            }
            GridRow {
                NavigationLink {
                    MathGameMode(gameMode: .multiply)
                } label: {
                    gameModeButton(gameMode: .multiply)
                }
                NavigationLink {
                    MathGameMode(gameMode: .division)
                } label: {
                    gameModeButton(gameMode: .division)
                }
            }
            GridRow {
                NavigationLink {
                    MathGameMode(gameMode: .automatic)
                } label: {
                    gameModeButton(gameMode: .automatic)
                        
                }
            }
            .gridCellColumns(2)
        }
        .foregroundStyle(.primary)
        .navigationBarBackButtonHidden(true)
    }
}




#Preview {
    ContentView()
}
