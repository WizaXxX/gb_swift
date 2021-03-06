//
//  Data.swift
//  vk
//
//  Created by WizaXxX on 01.06.2022.
//

import UIKit


public struct UserData {
    static var allFriends: [CommonUserData] = [Friend]().self
    static var myFriends: [CommonUserData] = [Friend]().self
    
    static var allGroups: [CommonUserData] = [Group]().self
    static var myGroups: [CommonUserData] = [Group]().self
    
    public  func generateData() {
        generateFriends()
        generateGroups()
    }
    
    private func generateFriends() {
        let images = getImages()
        for i in Range(0...100) {
            
            let friend = Friend(
                id: i,
                name: getUserName(),
                image: images.randomElement()!,
                nickName: randomString(((5..<10).randomElement())),
                age: (15...100).randomElement()!,
                photos: createPhotosToFriend(photos: images))
            
            if i % 4 == 0 {
                UserData.myFriends.append(friend)
            } else {
                UserData.allFriends.append(friend)
            }
        }
    }
    
    private func generateGroups() {
        let images = getImages()
        for i in Range(0...10) {
            let people = getNewMembersToGroup()
            let group = Group(
                id: i,
                name: randomString(((5..<15).randomElement())),
                image: images.randomElement()!,
                desc: randomString(((10..<600).randomElement())),
                people: people,
                countOfPeople: people.count)
            
            if i % 4 == 0 {
                UserData.myGroups.append(group)
            } else {
                UserData.allGroups.append(group)
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
    
    private func getImages() -> [UIImage] {
        return [
            UIImage(systemName: "heart.fill")!,
            UIImage(systemName: "heart")!,
            UIImage(systemName: "pencil")!,
            UIImage(systemName: "pencil.slash")!,
            UIImage(systemName: "folder")!,
            UIImage(systemName: "folder.fill")!,
            UIImage(systemName: "tray")!,
            UIImage(systemName: "tray.fill")!,
            UIImage(systemName: "book")!,
            UIImage(systemName: "book.fill")!]
    }
    
    private func getUserName() -> String {
        let names = ["Kameron", "Aimee", "Jaidyn", "Branson", "Naima", "Konner", "Jordan", "Celia", "Clay", "Breanna", "Lizeth", "Trey", "Leandro", "Raelynn"]
        let familyNames = ["Valenzuela", "Burch", "Oneill", "Rivers", "Rocha", "Woodard", "Murphy", "Cuevas", "Ibarra", "Tran", "Kane", "Holden", "Sims", "Spencer", "Jefferson", "Baker", "Ellison"]
        
        return "\(names.randomElement()!) \(familyNames.randomElement()!)"
    }
    
    private func createPhotosToFriend(photos: [UIImage]) -> [UIImage] {
        var friendPhotos = [UIImage]()
        
        for _ in 1 ..< 100 {
            friendPhotos.append(photos.randomElement()!)
        }
        
        return friendPhotos
    }
    
    private func getNewMembersToGroup() -> [CommonUserData] {
        
        let countOfMyFriend = (0..<UserData.myFriends.count).randomElement()
        let countOfAllFriend = (0..<UserData.allFriends.count).randomElement()
        
        var newMembers: [CommonUserData] = []
        for i in 0...countOfMyFriend! {
            newMembers.append(UserData.myFriends[i])
        }

        for i in 0...countOfAllFriend! {
            newMembers.append(UserData.allFriends[i])
        }
        
        return newMembers
    }
    
}
