//
//  VKPhoto.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

struct VKPhoto: Decodable {
    var id: Int
    var albumId: Int
    var date: Date
    var ownerId: Int
    var postId: Int?
    var sizes: [VKPhotoSize]
    var text: String
    var hasTags: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case date
        case ownerId = "owner_id"
        case postId = "post_id"
        case sizes
        case text
        case hasTags = "has_tags"
    }
}
