//
//  SubtractionMode.swift
//  MathGame
//
//  Created by Aidan Bergerson on 12/16/24.
//

import SwiftUI

struct MathGameMode: View {
    var gameMode: GameModes
    @Environment(\.dismiss) var dismiss
    
    @State private var userChoice = 0
    
    @State private var numberOne = Int.random(in: 0...100)
    @State private var numberTwo = Int.random(in: 0...100)
    @State private var sum: Int = 0
    
    @State private var alertTitle = ""
    @State private var alertPresented = false
    
    @State private var historyPresented = false
    
    @State private var gameOverPresented = false
    
    @State private var score = 0
    @State private var rounds = 0
    @State private var highScore = 0
    
    @State private var addHistory: [AddHistory] = []
    
    // turns the TextField value "0" into an empty string
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                Text("What is \(numberOne) \(gameMode.equationSigns) \(numberTwo)?")
                    .font(.title)
                
                // MARK: Text Field
                TextField("0", value: $userChoice, formatter: formatter)
                    .gameTextField()
                
                Button {
                    alertPresented = true
                    gameLogic()
                    gameOver()
                    userChoice = 0
                    
                    
                    
                    
                } label: {
                    Text("Enter")
                }
                .gameButtonStyle(width: 150)
                
                
                Text("Your score is \(score)")
                
                Spacer()
                
                Divider()
                
                Button {
                    dismiss()
                } label: {
                    Text("Exit Game Mode")
                }
                .gameButtonStyle(width: 250)
                
                
            }
            .navigationTitle("\(gameMode.rawValue) Mode")
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $historyPresented) {
                historySection()
                    .presentationDetents([.medium, .large])
            }
            .alert("Game Over!", isPresented: $gameOverPresented) {
                Button("Restart") {
                    calculateHighScore()
                }
            } message: {
                Text("You got \(score) out of 10 correct!")
            }
            .alert(alertTitle, isPresented: $alertPresented) {
                Button {
                    nextQuestion()
                } label: {
                    Text("Next")
                }
            } message: {
                Text("The answer was \(gameMode.performOperation(numberOne, numberTwo))")
            }
            .onSubmit {
                gameLogic()
                gameOver()
                alertPresented = true
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        historyPresented = true
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Text("High Score: \(highScore)")
                }
            }
        }
    }
    
    func gameLogic() {
        rounds += 1
        
        if userChoice == gameMode.performOperation(numberOne, numberTwo) {
            score += 1
            alertTitle = "Correct!"
        } else {
            alertTitle = "Incorrect"
        }
    }
    
    func nextQuestion() {
        sum = gameMode.performOperation(numberOne, numberTwo)
        
        addHistory.insert(AddHistory(numberOne: numberOne, numberTwo: numberTwo, userChoice: userChoice, sum: sum), at: 0)
        
        userChoice = 0
        
        numberOne = Int.random(in: 1...100)
        numberTwo = Int.random(in: 1...100)
    }
    
    func gameOver() {
        if rounds == 10 {
            gameOverPresented = true
        }
    }
    
    func calculateHighScore() {
        if score > highScore {
            highScore = score
        }
    }
    
    @ViewBuilder func historySection() -> some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(addHistory, id: \.id) { value in
                            VStack {
                                HStack {
                                    VStack {
                                        Text("\(value.numberOne) + \(value.numberTwo) = \(value.sum)")
                                        if value.userChoice != value.sum {
                                            Text("You entered \(value.userChoice)")
                                                .font(.footnote)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: value.userChoice == value.sum ? "checkmark.circle" : "x.circle")
                                }
                                .foregroundStyle(value.userChoice == value.sum ? Color.green : Color.red)
                                
                                Divider()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                         // do at some later date
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.orange)
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // add snack bar confirmation in future...
                        addHistory = [AddHistory]()
                    } label: {
                        Text("Clear")
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 30)
        }
    }
}


struct AddHistory: Codable {
    var id = UUID()
    let numberOne: Int
    let numberTwo: Int
    let userChoice: Int
    let sum: Int
}

#Preview {
    MathGameMode(gameMode: .addition)
}
