//
//  GroupsAPI.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//

import Foundation
import Combine

struct GroupItems: Codable {
     var items: [Group]
 }

 struct Group: Codable, Identifiable {
     var id: Double?
     var name: String?
     var screenName: String
     var photo: String?
     var description: String?

     enum CodingKeys: String, CodingKey {
         case id
         case name
         case screenName = "screen_name"
         case photo = "photo_50"
         case description
     }
 }

 extension Group {
     var photoUrl: URL? {
         URL(string: photo!)
     }
 }

 #if DEBUG
 let groupDemoData = GroupItems(items: [
    Group(screenName: "Investment"),
    Group(screenName: "Motorsport"),
    Group(screenName: "Travelling")
 ])
 #endif

class GroupModelView: ObservableObject {
    var groups: [Group] = []

    internal let objectWillChange = ObjectWillChangePublisher()
    private let apiService = APIService()

    public func fetch() {
        apiService.getGroups { [self] data in
            self.groups = data
            objectWillChange.send()
        }
    }
}
