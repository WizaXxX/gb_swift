//
//  Group.swift
//  vk
//
//  Created by Илья Козырев on 30.06.2022.
//

import UIKit

struct Group {
    var id: Int
    var name: String
    var image: UIImage
    var desc: String
    var people: [CommonUserData]
    var countOfPeople: Int
}
