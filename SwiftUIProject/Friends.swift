//
//  Friends.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine

class Friend: Identifiable {
    
    let id: UUID = UUID()
    let firstName: String
    let secondName: String
    
    internal init(firstName: String, secondName: String) {
        self.firstName = firstName
        self.secondName = secondName
    }
}

struct FriendsView: View {
    
    @State private var friends: [Friend] = [
    Friend(firstName: "Гена", secondName: "Крокодил"),
    Friend(firstName: "Чебурашка", secondName: "Знатный"),
    Friend(firstName: "Винни", secondName: "Пух")
    ]
    
    var body: some View {
        List(friends.sorted(by: {$0.firstName < $1.firstName})) { friend in
            Text("\(friend.firstName) \(friend.secondName)")
        }
        .navigationTitle("Friends")
    }
}

struct FriendView_Preview: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
