//
//  MainView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine

struct MainView: View {
    
    var body: some View {
        
        TabView {
            FriendsView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Friends")
                }
            GroupsView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Groups")
                }
            FriendPhotoView()
                .tabItem {
                    Image(systemName: "tray.2")
                    Text("Friend photo")
                }
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
