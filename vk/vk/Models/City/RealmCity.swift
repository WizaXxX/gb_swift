//
//  RealmCity.swift
//  vk
//
//  Created by Илья Козырев on 08.08.2022.
//

import Foundation

import RealmSwift

class RealmCity: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var title: String
}
