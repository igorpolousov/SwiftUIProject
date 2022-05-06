//
//  FriendsAPI.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//

import Foundation
import Combine

var friends = [Friend]()

struct FriendItems: Codable {
    var items: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: Double?
    var firstName: String
    var lastName: String
    var nickName: String?
    var photo: String?
    var domain: String?
    var sex: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case nickName = "nickname"
        case photo = "photo_100"
        case domain
        case sex
    }
}

extension Friend {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

extension Friend {
    var photoUrl: URL? {
        URL(string: photo!)
    }
}


#if DEBUG
let friendDemoData =  FriendItems(items: [
    Friend(firstName: "Гена", lastName: "Крокодил"),
    Friend(firstName: "Чебурашка", lastName: "Знатный"),
    Friend(firstName: "Винни", lastName: "Пух")
])
#endif


class FriendModelView: ObservableObject {
    @Published var friends: [Friend] = []
    private let apiService = APIService()

    public func fetch() {
        apiService.getFriends { data in
            self.friends = data
        }
    }
}
