//
//  DetailView.swift
//  Friendface
//
//  Created by Nazarii Zomko on 21.09.2022.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser
//    @ObservedObject var usersManager: UsersManager
    
    var body: some View {
        Form {
            Section("Basic info") {
                Text("Name: \(user.wrappedName)")
                Text("Age: \(user.age)")
                Text("Company: \(user.wrappedCompany)")
                Text("Email: \(user.wrappedEmail)")
                Text("Address: \(user.wrappedAddress)")
                Text("Registered: \(user.wrappedRegistered)")
                Text("About: \(user.wrappedAbout)")
            }
            
            Section("Tags") {
                Group {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            let tags = user.wrappedTags.components(separatedBy: ",")
                            ForEach(tags, id: \.self) { tag in
                                Text("\(tag)")
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.black)
                                    .background(
                                        Rectangle()
                                            .cornerRadius(7)
                                            .foregroundColor(Color("lightBlue"))
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }

            Section("Friends") {
                List(user.friendsArray) { friend in
                    Text("\(friend.wrappedName)")

                    
//                    if let friendAsUser = usersManager.getUser(id: friend.id) {
//                        NavigationLink(destination: DetailView(user: friendAsUser, usersManager: usersManager)) {
//                            Text("\(friend.name)")
//                        }
//                    }
                }
            }
        }
        .onAppear(perform: printCount)

        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func printCount() {
        print(user.friendsArray.count)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User(id: UUID(), isActive: true, name: "Test Name", age: 32, company: "Google LLC", email: "email@gmail.com", address: "Some address", about: "About string...", registered: Date.now, tags: ["one", "two", "three"], friends: [Friend(id: UUID(), name: "Jake")]))
//    }
//}
