//
//  RealmFriend.swift
//  vk
//
//  Created by Илья Козырев on 08.08.2022.
//

import Foundation
import RealmSwift

class RealmFriend: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var nickname: String?
    @Persisted var sSizePhoto: String
    @Persisted var mSizePhoto: String
    @Persisted var xSizePhoto: String
    @Persisted var trackCode: String
    @Persisted var sex: Int
    @Persisted var city: RealmCity?
    @Persisted var lastSeen: Int?
}
