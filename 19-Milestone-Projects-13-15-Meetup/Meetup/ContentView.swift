//
//  ContentView.swift
//  Meetup
//
//  Created by Nazarii Zomko on 01.10.2022.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.people) { person in
                        NavigationLink(destination: DetailView(person: person, onSave: { newPerson in
                            viewModel.update(person: newPerson)
                        })) {
                            HStack {
                                Image(uiImage: person.image)
                                    .resizable()
                                    .cornerRadius(4)
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text(person.name)
                                    .padding(.horizontal)
                            }
                        }
                        
                        // another way to show DetailView (with a sheet)
//                        .onTapGesture {
//                            print("name", person.name)
//                            viewModel.selectedPerson = person
//                        }
                    }
                    .onDelete { offsets in
                        viewModel.remove(at: offsets)
                    }
                    
                }
                .alert("Name", isPresented: $viewModel.isAddNameAlertShowing) {
                    TextField("Name", text: $viewModel.selectedImageName)
                    Button("Add Person") {
                        viewModel.addPerson()
                    }
                    Button("Cancel", role: .cancel) { }
                }
                .onChange(of: viewModel.selectedPhotosPickerItem) { _ in
                    print("ON CHANGE FIRED")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.selectedImageName = ""
                        viewModel.isAddNameAlertShowing = true
                    }
                }
            }
            .toolbar() {
                ToolbarItem {
                    PhotosPicker(
                        selection: $viewModel.selectedPhotosPickerItem,
                        matching: .images
                    ) {
                        Image(systemName: "plus")
                    }
                }
            }
//            .sheet(item: $viewModel.selectedPerson) { person in
//                DetailView(person: person) { newPerson in
//                    viewModel.update(person: newPerson)
//                }
//            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
