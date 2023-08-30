//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Nazarii Zomko on 15.10.2022.
//

import SwiftUI

enum SortType: String, CaseIterable {
    case def = "Default"
    case name = "Name"
    case country = "Country"
}

enum SortOrder: String, CaseIterable {
    case ascending = "Ascending"
    case descending = "Descending"
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var sortType: SortType = .def
    @State private var sortOrder: SortOrder = .ascending
    
    var body: some View {
        NavigationView {
            List(sortedFilteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                Menu() {
                    Picker("Sort Type", selection: $sortType) {
                        ForEach(SortType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Sort Order", selection: $sortOrder) {
                        ForEach(SortOrder.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } label: {
                    HStack {
                        Text("Sort By")
                        Label("Sort By", systemImage: "arrow.up.arrow.down")
                            .font(.footnote)
                    }
                }
            }
        }
        .environmentObject(favorites)
    }
    
    var sortedFilteredResorts: [Resort] {
        switch sortType {
        case .def:
            return sortOrder == .ascending ? filteredResorts : filteredResorts.reversed()
        case .name:
            return filteredResorts.sorted { sortOrder == .ascending ? $0.name < $1.name : $0.name > $1.name }
        case .country:
            return filteredResorts.sorted { sortOrder == .ascending ? $0.country < $1.country : $0.country > $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
