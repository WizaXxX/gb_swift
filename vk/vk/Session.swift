//
//  Session.swift
//  vk
//
//  Created by Илья Козырев on 06.07.2022.
//

import Foundation

class Session {
    
    static let instance = Session()
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    
}
