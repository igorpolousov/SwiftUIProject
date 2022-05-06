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
        Group(groupName: "Investment"),
        Group(groupName: "Motorsport"),
        Group(groupName: "Travelling")
    ]
    
    var body: some View {
        List(groups.sorted(by: {$0.groupName < $1.groupName})) { group in
            
                Text("\(group.groupName)")
            
        }
        .navigationTitle("Groups")
    }
}

struct GroupsView_Preview: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
