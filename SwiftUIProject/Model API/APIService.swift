//
//  APIService.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//

import Foundation
import UIKit

class APIService {
    let session = URLSession.shared
    var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        return components
    }()
    
  // MARK: Get friends
       func getFriends(completion: @escaping ([Friend]) -> Void) {
           guard let url = prepareUrl(
               methodName: "friends.get",
               params: [URLQueryItem(name: "fields", value: "photo_100, nickname, domain, sex, bdate, city, country")]
           )
           else { return }

           vkRequest(url: url) { resp in
               do {
                   let friendList = try JSONDecoder()
                       .decode(VKResponse<FriendItems>.self, from: resp)
                   completion(friendList.response.items)
               } catch {
                   print("getFriends: Что-то пошло не так c JSONDecoder!")
               }
           }
       }
    
    private func prepareUrl(methodName: String, params: [URLQueryItem]?) -> URL? {
            urlComponents.path = "/method/" + methodName
            urlComponents.queryItems = [
                URLQueryItem(
                    name: "user_ids",
                    value: String(AuthData.share.userId)
                ),
                URLQueryItem(
                    name: "access_token",
                    value: AuthData.share.token
                ),
                URLQueryItem(
                    name: "v",
                    value: "5.131"
                ),
            ]

            if let p = params {
                for itemParam in p {
                    urlComponents.queryItems?.append(itemParam)
                }
            }

            return urlComponents.url
        }

        private func vkRequest(url: URL, completion: @escaping (Data) -> Void) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 10.0

            session.dataTask(with: request) { responseData, urlResponse, error in
                if let response = urlResponse as? HTTPURLResponse {
                    print("Код ответа: \(response.statusCode)")
                }
                guard
                    error == nil,
                    let responseData = responseData
                else { return }

                // debug
    //            let json = try? JSONSerialization.jsonObject(
    //                with: responseData,
    //                options: .fragmentsAllowed)
    //                print(json)
                do {
                    DispatchQueue.main.async {
                        completion(responseData)
                    }
                } catch {
                    print("Ошибка при получении ответа: \(error)")
                }
            }
            .resume()
        }
}
