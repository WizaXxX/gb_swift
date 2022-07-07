//
//  Session.swift
//  vk
//
//  Created by Илья Козырев on 06.07.2022.
//

import Foundation

class Session {
    private init() {}
    
    static let instance = Session()
    
    var token: String = ""
    var userId: Int = 0
    
}
