//
//  GroupsAPI.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//

import Foundation

class Group: Identifiable {
    var id: UUID = UUID()
    var groupName: String
    
    internal init(groupName: String) {
        self.groupName = groupName
    }
}
