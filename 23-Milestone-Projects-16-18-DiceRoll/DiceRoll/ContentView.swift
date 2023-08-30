//
//  ContentView.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 13.10.2022.
//

// TODO: Use MVVM +
// TODO: Design HistoryView  +
// TODO: Store history with JSON or Core Data +
// TODO: Add haptic feedback +
// TODO: Make the dice flick before showing final result +
// TODO: Add edit button in HistoryView +
// TODO: USE @EnvironmentObject instead of creating the HisvoryViewVM inside ContentViewVM...

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewVM()
    
    let columns = [
        GridItem(.fixed(100), spacing: 20),
        GridItem(.fixed(100), spacing: 20)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if viewModel.diceItems.count == 1 {
                    DiceView(diceItem: viewModel.diceItems[0], isFlicking: viewModel.isDicesFlicking)
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.diceItems) { diceItem in
                            DiceView(diceItem: diceItem, isFlicking: viewModel.isDicesFlicking)
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Text("Sides: \(viewModel.numberOfSides.formatted())")
                    Spacer()
                    Slider(value: $viewModel.numberOfSides, in: 4...100, step: 2)
                        .frame(width: 200)
                }
                
                Stepper("Dices: \(viewModel.numberOfDices)", value: $viewModel.numberOfDices, in: 1...4)
                
                Button("ROLL") {
                    viewModel.rollDices()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule(style: .continuous))
                .disabled(viewModel.isRollButtonDisabled)
                .opacity(viewModel.isRollButtonDisabled ? 0.7 : 1)
            }
            .padding()
            .navigationTitle("DiceRoll")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        HistoryView(historyViewVM: viewModel.historyVM)
                    } label: {
                        Text("History")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Total: \(viewModel.total)")
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
