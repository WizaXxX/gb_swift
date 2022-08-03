//
//  Alert.swift
//  lesson-3.4-json.decoder
//
//  Created by Илья Козырев on 19.07.2022.
//

import Foundation

struct Alert: Decodable {
    let senderName: String
    let event: String
    let start: Date
    let end: Date
    let description: String
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event, start, end, description, tags
    }
}
