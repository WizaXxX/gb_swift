//
//  VKPhotoSize.swift
//  vk
//
//  Created by Илья Козырев on 13.07.2022.
//

import Foundation

struct VKPhotoSize: Decodable {
    var height: Int
    var width: Int
    var type: String
    var url: String
}
