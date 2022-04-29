//
//  Groups.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine

class Group: Identifiable {
    var id: UUID = UUID()
    var groupName: String
    
    internal init(groupName: String) {
        self.groupName = groupName
    }
}

struct GroupsView: View {
    
    @State private var groups: [Group] = [
        Group(groupName: "Investment"),
        Group(groupName: "Motorsport"),
        Group(groupName: "Travalling")
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
