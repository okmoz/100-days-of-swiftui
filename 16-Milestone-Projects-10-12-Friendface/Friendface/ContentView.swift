
//  ContentView.swift
//  Friendface
//
//  Created by Nazarii Zomko on 20.09.2022.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
//            activityin
            List(cachedUsers, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        Circle()
                            .frame(width: 6)
                            .foregroundColor(user.isActive ? .green : .gray)
                        Text(user.wrappedName)
                    }
                }
            }
            .task {
                if cachedUsers.isEmpty {
                    if let fetchedUsers = await getUsersFromAPI() {
                        users = fetchedUsers
                    }
                    await MainActor.run {
                        for user in users {
                            let newUser = CachedUser(context: moc)
                            newUser.name = user.name
                            newUser.id = user.id
                            newUser.isActive = user.isActive
                            newUser.age = Int16(user.age)
                            newUser.about = user.about
                            newUser.email = user.email
                            newUser.address = user.address
                            newUser.company = user.company
                            newUser.registered = user.registered
                            newUser.tags = user.tags.joined(separator: ",")
                            
                            for friend in user.friends {
                                let newFriend = CachedFriend(context: moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newFriend.user = newUser
                            }
                            
//                            print("here 3")
                            try? moc.save()
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
    
    func getUsersFromAPI() async -> [User]? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedUsersArray = try? decoder.decode([User].self, from: data) {
                return decodedUsersArray
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
        
        return nil
    }
    
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
