//
//  DetailView.swift
//  Meetup
//
//  Created by Nazarii Zomko on 02.10.2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Person) -> Void
    
    @StateObject var viewModel: ViewModel
    
//    let annotation = [Person.example]
    
    init(person: Person, onSave: @escaping (Person) -> Void) {
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            Image(uiImage: viewModel.person.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            
            HStack {
                Text("LOCATION")
                    .padding(.horizontal, 8)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Spacer()
            }
            ZStack {
                if viewModel.person.coordinate != nil {
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: [viewModel.person]) {
                        MapMarker(coordinate: $0.coordinate!)
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color(UIColor.lightGray))
                        Text("Location is unavailable.")
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(height: 180)
            Spacer()
        }
        .navigationTitle(viewModel.person.name)
        .alert("Name", isPresented: $viewModel.isChangeNameAlertShowing) {
            TextField("Name", text: $viewModel.person.name)
            Button("Save") {
                onSave(viewModel.person)
            }
        }
        .toolbar() {
            Button("Change name") {
                viewModel.isChangeNameAlertShowing = true
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(person: Person.example) { _ in }
        }
    }
}
