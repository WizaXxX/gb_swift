//
//  RealmGroup.swift
//  vk
//
//  Created by Илья Козырев on 08.08.2022.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var screenName: String
    @Persisted var type: String
    @Persisted var sSizePhoto: String
    @Persisted var mSizePhoto: String
    @Persisted var lSizePhoto: String
    @Persisted var membersCount: Int
    @Persisted var desc: String
    @Persisted var status: String
}
