//
//  VKGroup.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

struct VKGroup: Decodable {
    var id: Int
    var name: String
    var screenName: String
    var type: String
    var sSizePhoto: String
    var mSizePhoto: String
    var lSizePhoto: String
    var membersCount: Int
    var description: String
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case type
        case sSizePhoto = "photo_50"
        case mSizePhoto = "photo_100"
        case lSizePhoto = "photo_200"
        case membersCount = "members_count"
        case description, status
        
    }
}
