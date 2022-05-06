//
//  Groups.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine



struct GroupsView: View {
    
    @State private var groups: [Group] = [
        Group(screenName: "Investment"),
        Group(screenName: "Motorsport"),
        Group(screenName: "Travelling")
    ]
    
    var body: some View {
        List(groups.sorted(by: {$0.screenName < $1.screenName})) { group in
            
                Text("\(group.screenName)")
            
        }
        .navigationTitle("Groups")
    }
}

struct GroupsView_Preview: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
