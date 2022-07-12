//
//  Networker.swift
//  vk
//
//  Created by Илья Козырев on 10.07.2022.
//

import Foundation

enum Method: String {
    case getFriends = "friends.get"
    case getPhotos = "photos.getAll"
    case getGroups = "groups.get"
    case searchGroups = "groups.search"
}

class Networker {
    private init(urlSesstion: URLSession = .shared) {
        self.urlSesstion = urlSesstion
    }
    
    static let shared = Networker()
    private let urlSesstion: URLSession
    
    private func createUrl(method: Method, methodParams: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/\(method.rawValue)"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: Resouces.VKAPI.version)
        ]
        
        for (key, value) in methodParams {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        return urlComponents.url
    }
    
    private func sendGetRequest(url: URL) {
    
        urlSesstion.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {
                return
            }
            
            print(String(data: data, encoding: .utf8))
        }.resume()
    }
    
    func getFriends() {
        guard let url = createUrl(method: .getFriends, methodParams: [:]) else { return }
        sendGetRequest(url: url)
    }
    
    func getPhotos(ownerId: String) {
        guard let url = createUrl(method: .getPhotos, methodParams: ["owner_id": ownerId]) else { return }
        sendGetRequest(url: url)
    }
    
    func getGroups() {
        guard let url = createUrl(method: .getGroups, methodParams: [:]) else { return }
        sendGetRequest(url: url)
    }
    
    func searchGoups(query: String) {
        guard let url = createUrl(method: .searchGroups, methodParams: ["q": query]) else { return }
        sendGetRequest(url: url)
    }
}
