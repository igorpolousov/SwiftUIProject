//
//  FriendsAPI.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//

import Foundation

class Friend: Identifiable {
    
    let id: UUID = UUID()
    let firstName: String
    let secondName: String
    
    internal init(firstName: String, secondName: String) {
        self.firstName = firstName
        self.secondName = secondName
    }
}
