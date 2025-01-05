//
//  CustomViews.swift
//  MathGame
//
//  Created by Aidan Bergerson on 12/16/24.
//

import SwiftUI

struct GameTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.headline)
            .frame(width: 150, height: 50, alignment: .center)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .stroke(Color.gray, lineWidth: 2)
            }
    }
}

// MARK: Game Mode Button Struct
struct gameModeButton: View {
    var gameMode: GameModes
    
    var body: some View {
            Text(gameMode.rawValue)
                .frame(maxWidth: .infinity / 2)
                .frame(height: 100)
                .background(.thickMaterial.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(Color.gray, lineWidth: 2)
                )
    }
}

struct GameButtonStyle: ViewModifier {
    var width: Double
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white).fontWeight(.semibold)
            .frame(width: width, height: 40)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func gameTextField() -> some View {
        modifier(GameTextField())
    }
    
    func gameButtonStyle(width: Double) -> some View {
        modifier(GameButtonStyle(width: width))
    }
}
