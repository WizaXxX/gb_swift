//
//  VKUserData.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

class VKUserData {
    private init() {}
    
    static let instance = VKUserData()
    
    var friends: [VKFriend] = [VKFriend]()
    var photos: [VKPhoto] = [VKPhoto]()
    var groups: [VKGroup] = [VKGroup]()
}
