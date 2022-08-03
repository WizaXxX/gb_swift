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
    func prepareSegue(segue: UIStoryboardSegue)
    
}

extension Friend: CommonUserData {
    
    func getDescription() -> String {
        return nickName
    }
    
    func getNumbersData() -> Int {
        return age
    }
    
    func segueFromItemListToItem() -> String? {
        return ""
    }
    
    func prepareSegue(segue: UIStoryboardSegue) {
        
        guard segue.identifier == segueFromItemListToItem() else {
            return
        }
        
        let view = segue.destination as! FriendViewController
        view.configure(friend: self)
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
    
    func prepareSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == segueFromItemListToItem() else {
            return
        }
        
        let view = segue.destination as! GroupViewController
        view.configure(group: self)
    }
}
