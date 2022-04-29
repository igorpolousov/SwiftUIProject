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
    var groupImage: UIImage
    
    internal init(groupName: String, groupImage: UIImage) {
        self.groupName = groupName
        self.groupImage = groupImage
    }
}

struct GroupsView: View {
    
    @State private var groups: [Group] = [
        Group(groupName: "Investment", groupImage: UIImage(contentsOfFile: "wti")!),
        Group(groupName: "Motorsport", groupImage: UIImage(contentsOfFile: "motorsport")!),
        Group(groupName: "Travalling", groupImage: UIImage(contentsOfFile: "witch")!)
    ]
    
    var body: some View {
        List(groups.sorted(by: {$0.groupName < $1.groupName})) { group in
            HStack {
                Image("\(group.groupImage)")
                Text("\(group.groupName)")
            }
        }
        .navigationTitle("Groups")
    }
}

