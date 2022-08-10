//
//  Friend.swift
//  vk
//
//  Created by Илья Козырев on 08.08.2022.
//

import Foundation

struct Friend {
    var id: Int
    var firstName: String
    var lastName: String
    var nickname: String?
    var sSizePhoto: String
    var mSizePhoto: String
    var sex: Int
    var city: City
    var lastSeen: Date?
}
