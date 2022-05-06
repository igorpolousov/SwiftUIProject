//
//  VKResponse.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//



struct VKResponse<T: Codable> {
    let response: T
}

extension VKResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case response
    }
}
