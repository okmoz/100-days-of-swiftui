//
//  ContentView.swift
//  iExpense
//
//  Created by Nazarii Zomko on 29.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            ItemView(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Business")
                }
                
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            ItemView(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal")
                }

            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ItemView: View {
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .foregroundColor(getAmountColor(forAmount: item.amount))
        }
    }
    
    func getAmountColor(forAmount amount: Double) -> Color {
        switch amount {
        case ..<10:
            return .green
        case 10..<100:
            return .yellow
        default:
            return .red
        }
    }
}
