//
//  Data.swift
//  vk
//
//  Created by WizaXxX on 01.06.2022.
//

import UIKit


public struct Data {
    static var allFriends = [Friend]().self
    static var myFriends = [Friend]().self
    
    static var allGroups = [Group]().self
    static var myGroups = [Group]().self
    
    private let images = [
        UIImage(systemName: "heart.fill"),
        UIImage(systemName: "heart"),
        UIImage(systemName: "pencil"),
        UIImage(systemName: "pencil.slash"),
        UIImage(systemName: "folder"),
        UIImage(systemName: "folder.fill"),
        UIImage(systemName: "tray"),
        UIImage(systemName: "tray.fill"),
        UIImage(systemName: "book"),
        UIImage(systemName: "book.fill")]
    
    public func generateData() {
        generateFriends()
        generateGroups()
    }
    
    private func generateFriends() {
        
        for i in Range(0...10) {
            
            let friend = Friend(
                id: i,
                name: randomString(((5..<15).randomElement())),
                nickName: randomString(((5..<60).randomElement())),
                age: (15...100).randomElement()!,
                image: images.randomElement()!!)
            
            if i % 4 == 0 {
                Data.myFriends.append(friend)
            } else {
                Data.allFriends.append(friend)
            }
        }
    }
    
    private func generateGroups() {
        
        for i in Range(0...10) {
            let group = Group(
                id: i,
                name: randomString(((5..<15).randomElement())),
                desc: randomString(((10..<600).randomElement())),
                countOfPeople: (1...1000).randomElement()!,
                image: images.randomElement()!!)
            
            if i % 4 == 0 {
                Data.myGroups.append(group)
            } else {
                Data.allGroups.append(group)
            }
        }
    }
    
    private func randomString(_ countOfLetters: Int?) -> String {
        guard let length = countOfLetters else {
            return "None"
        }
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
}
