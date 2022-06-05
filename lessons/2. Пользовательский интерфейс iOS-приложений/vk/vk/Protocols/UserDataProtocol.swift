//
//  UserDataProtocol.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//

import UIKit

protocol CommonUserData {
        
    var id: Int { get set }
    var name: String { get set }
    var image: UIImage { get set }
    
    func getDescription() -> String
    func getNumbersData() -> Int
    func segueFromItemListToItem() -> String?
    
}

extension Friend: CommonUserData {
    
    func getDescription() -> String {
        return nickName
    }
    
    func getNumbersData() -> Int {
        return age
    }
    
    func segueFromItemListToItem() -> String? {
        return Resouces.Segue.fromFriendListToFriend
    }
    
}

extension Group: CommonUserData {
    
    func getDescription() -> String {
        return desc
    }
    
    func getNumbersData() -> Int {
        return countOfPeople
    }
    
    func segueFromItemListToItem() -> String? {
        return Resouces.Segue.fromGroupListToGroup
    }
}
