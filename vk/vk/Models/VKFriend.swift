//
//  VKFriend.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

struct VKFriend: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var nickname: String
    var canAccessClosed: Bool
    var sSizePhoto: String
    var trackCode: String
    var isClosed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
        case canAccessClosed = "can_access_closed"
        case sSizePhoto = "photo_50"
        case trackCode = "track_code"
        case isClosed = "is_closed"
    }
}
