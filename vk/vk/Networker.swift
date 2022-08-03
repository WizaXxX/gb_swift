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
    let jsonDecoder = JSONDecoder()
    
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
    
    private func sendGetRequest<TypeOfResponse: Decodable>(
        url: URL,
        type: TypeOfResponse.Type,
        completion: @escaping (TypeOfResponse?)->()) {
    
        urlSesstion.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {
                return
            }
            
            do {
                let resultModel = try self.jsonDecoder.decode(VKResponse<TypeOfResponse>.self, from: data)
                completion(resultModel.response)
            }
            catch {
                print(error)
            }
            
        }.resume()
    }
    
    func getFriends(completion: @escaping () -> Void) {
        let urlParams = ["fields": "nickname,photo_50,sex,city,photo_200_orig,photo_100"]
        guard let url = createUrl(method: .getFriends, methodParams: urlParams) else { return }

        sendGetRequest(url: url, type: VKArrayResult<VKFriend>.self) { response in
            guard let friends = response?.items else { return }
            VKUserData.instance.friends = friends
            completion()
        }
    }
    
    func getPhotos(ownerId: Int, complition: @escaping (_ photos: [VKPhoto]) -> Void) {
        guard let url = createUrl(method: .getPhotos, methodParams: ["owner_id": String(ownerId)]) else { return }
        
        sendGetRequest(url: url, type: VKArrayResult<VKPhoto>.self) { response in
            guard let photos = response?.items else { return }
            complition(photos)
        }
    }
    
    func getGroups() {
        let urlParams = ["extended": "1"]
        guard let url = createUrl(method: .getGroups, methodParams: urlParams) else { return }
        sendGetRequest(url: url, type: VKArrayResult<VKGroup>.self) { response in
            guard let groups = response?.items else { return }
            VKUserData.instance.groups = groups
        }
    }
    
    func searchGoups(query: String) {
        guard let url = createUrl(method: .searchGroups, methodParams: ["q": query]) else { return }
        sendGetRequest(url: url, type: VKArrayResult<VKGroup>.self) { response in
//            print(response)
        }
    }
}
