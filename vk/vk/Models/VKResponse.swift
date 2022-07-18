//
//  VKResponse.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

struct VKResponse<Response: Decodable>: Decodable {
    let response: Response
}

struct VKArrayResult<TypeOfItems: Decodable>: Decodable {
    let count: Int
    let items: [TypeOfItems]
}
