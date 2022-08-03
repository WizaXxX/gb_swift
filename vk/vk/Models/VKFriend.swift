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
    var nickname: String?
    var sSizePhoto: String
    var mSizePhoto: String
    var xSizePhoto: String
    var trackCode: String
    var sex: Int
    var city: VKCity?
    var lastSeen: VKLastSeen?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
        case sSizePhoto = "photo_50"
        case mSizePhoto = "photo_100"
        case xSizePhoto = "photo_200_orig"
        case trackCode = "track_code"
        case sex
        case city
        case lastSeen = "last_seen"
    }
}
