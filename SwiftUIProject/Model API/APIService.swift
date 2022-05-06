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
    
    // MARK: Get groups
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
           guard let url = prepareUrl(
               methodName: "groups.get",
               params: [
                   URLQueryItem(name: "extended", value: "1"),
                   URLQueryItem(name: "fields", value: "description"),
               ]
           )
           else { return }

           vkRequest(url: url) { resp in
               do {
                   let groupList = try JSONDecoder()
                       .decode(VKResponse<GroupItems>.self, from: resp)
                   completion(groupList.response.items)
               } catch {
                   print("getGroups: Что-то пошло не так c JSONDecoder!")
               }
           }
       }
    
    // MARK: Get news
        func getNews(startFrom: String? = nil, completion: @escaping (NewsResponse) -> Void) {
            var params = [
                URLQueryItem(name: "count", value: "5"),
                URLQueryItem(name: "filters", value: "post,photo,note"),
                URLQueryItem(name: "fields", value: "first_name,last_name,photo_100,photo_50,description"),
                URLQueryItem(name: "start_time", value: "\(NSDate().timeIntervalSince1970 + 1)"),
            ]

            if startFrom != nil {
                params.append(URLQueryItem(name: "start_from", value: startFrom))
            }
            guard let url = prepareUrl(
                methodName: "newsfeed.get",
                params: params
            )
            else { return }

            let dispGroup = DispatchGroup()
            var newsList = NewsItems(items: [NewsPost]())
            var newsProfile = NewsProfiles(profiles: [Friend]())
            var newsGroup = NewsGroups(groups: [Group]())
            var nextFrom = ""

            vkRequest(url: url) { resp in
                DispatchQueue.global().async(group: dispGroup) {
                    do {
                        newsList = try JSONDecoder()
                            .decode(VKResponse<NewsItems>.self, from: resp).response

                        newsProfile = try JSONDecoder()
                            .decode(VKResponse<NewsProfiles>.self, from: resp).response

                        newsGroup = try JSONDecoder()
                            .decode(VKResponse<NewsGroups>.self, from: resp).response

                        nextFrom = try JSONDecoder()
                            .decode(VKResponse<NewsNextFrom>.self, from: resp).response.nextFrom

                    } catch {
                        print("getNews: Что-то пошло не так c JSONDecoder!", error.localizedDescription)
                    }
                }

                dispGroup.notify(queue: .main) {
                    completion(NewsResponse(
                        newsItems: newsList,
                        groupItems: newsGroup,
                        profileItems: newsProfile,
                        nextFrom: nextFrom
                    ))
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
