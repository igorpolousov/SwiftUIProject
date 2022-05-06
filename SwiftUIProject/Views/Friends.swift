//
//  Friends.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine



struct FriendsView: View {
    
    var body: some View {
        List(friends.sorted(by: {$0.firstName < $1.firstName})) { friend in
            Text("\(friend.firstName) \(friend.lastName)")
        }
        .navigationTitle("Friends")
    }
}

struct FriendView_Preview: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
