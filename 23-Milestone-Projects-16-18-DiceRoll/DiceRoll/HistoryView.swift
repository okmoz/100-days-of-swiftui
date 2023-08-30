//
//  HistoryView.swift
//  DiceRoll
//
//  Created by Nazarii Zomko on 13.10.2022.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel: HistoryViewVM
    
    init(historyViewVM: HistoryViewVM) {
        _viewModel = StateObject(wrappedValue: historyViewVM)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.historyEntries) { entry in
                HStack {
                    Text("Total: \(getTotal(diceItems: entry.diceItems)); Dices: \(entry.diceItems.map({"\($0.number)"}).joined(separator: ", "))")
                        .font(.caption)
                    Spacer()
                    Text("\(entry.date.formatted(date: .numeric, time: .shortened))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: viewModel.remove)
        }
        .toolbar {
            EditButton()
        }
        .navigationTitle("Total entries: \(viewModel.historyEntries.count)")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func getTotal(diceItems: [DiceItem]) -> Int {
        diceItems.reduce(0) { $0 + $1.number }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView(historyViewVM: HistoryViewVM())
        }
    }
}
