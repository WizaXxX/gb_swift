//
//  DataManager.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//

import UIKit

protocol DataManager {
    
    var countOfMyData: Int { get }
    var countOfAllData: Int { get }
    func getFromMyData(at index: Int) -> CommonUserData
    func getFromAllData(at index: Int) -> CommonUserData
    func moveFromMyDataToAllData(data: CommonUserData)
    func moveFromAllDataToMyData(data: CommonUserData)
    func addActionName() -> String
}

class UserFriendsDataManager: DataManager {
    
    var countOfMyData: Int {
        return UserData.myFriends.count
    }
    
    var countOfAllData: Int {
        return UserData.allFriends.count
    }
    
    func getFromMyData(at index: Int) -> CommonUserData {
        return UserData.myFriends[index]
    }
    
    func getFromAllData(at index: Int) -> CommonUserData {
        return UserData.allFriends[index]
    }
    
    func moveFromAllDataToMyData(data: CommonUserData) {
        let indexForDelete = UserData.allFriends.firstIndex(where: { $0.id == data.id })
        UserData.allFriends.remove(at: indexForDelete!)
        UserData.myFriends.append(data)
        NotificationCenter.default.post(name: Notification.Name(Resouces.Notification.addFriend), object: nil)
    }
    
    func moveFromMyDataToAllData(data: CommonUserData) {
        let indexForDelete = UserData.myFriends.firstIndex(where: { $0.id == data.id })
        UserData.myFriends.remove(at: indexForDelete!)
        UserData.allFriends.append(data)
    }
    
    func addActionName() -> String {
        return "Добавить в друзья"
    }

}

class UserGroupsDataManager: DataManager {
    
    var countOfMyData: Int {
        return UserData.myGroups.count
    }
    
    var countOfAllData: Int {
        return UserData.allGroups.count
    }
    
    func getFromMyData(at index: Int) -> CommonUserData {
        return UserData.myGroups[index]
    }
    
    func getFromAllData(at index: Int) -> CommonUserData {
        return UserData.allGroups[index]
    }
    
    func moveFromAllDataToMyData(data: CommonUserData) {
        let indexForDelete = UserData.allGroups.firstIndex(where: { $0.id == data.id })
        UserData.allGroups.remove(at: indexForDelete!)
        UserData.myGroups.append(data)
        NotificationCenter.default.post(name: Notification.Name(Resouces.Notification.addGroup), object: nil)
    }
    
    func moveFromMyDataToAllData(data: CommonUserData) {
        let indexForDelete = UserData.myGroups.firstIndex(where: { $0.id == data.id })
        UserData.myGroups.remove(at: indexForDelete!)
        UserData.allGroups.append(data)
    }
    
    func addActionName() -> String {
        return "Вступить в группу"
    }

}
