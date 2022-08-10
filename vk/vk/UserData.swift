//
//  UserData.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

class UserData {
    private init() {}
    
    static let instance = UserData()
    
    var friends: [Friend] = [Friend]()
    var photos: [VKPhoto] = [VKPhoto]()
    var groups: [Group] = [Group]()
}
