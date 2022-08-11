//
//  Gate.swift
//  vk
//
//  Created by Илья Козырев on 08.08.2022.
//

import Foundation
import RealmSwift
import FirebaseFirestore

enum ErrorType: Error {
    case CantCreateRealm
}

class Gate {
    private init() {}
    static let shared = Gate()
    
    let friendsKeyName = "friendsLastDateUpdate"
    let groupsKeyName = "groupsLastDateUpdate"
    
    let db = Firestore.firestore()
    
    private func needUpdate(_ lastDateUpdate: Int) -> Bool {
        
        if lastDateUpdate == 0 { return true }
        let dateNow = Date()
        
        return (Int(dateNow.timeIntervalSince1970) - lastDateUpdate) >= 5 // Обновляем не чаще чем в 5 сек
        
    }
}

extension Gate {

    func getFriends() async {
        
        let lastDateUpdate = UserDefaults.standard.integer(forKey: friendsKeyName)
        if needUpdate(lastDateUpdate) {
            guard let friends = try? await Networker.shared.getFriendAsync() else { return }
            writeFriendsToRealm(friends: friends)
            UserDefaults.standard.set(Int(Date().timeIntervalSince1970), forKey: friendsKeyName)
        }
    }
    
    private func writeFriendsToRealm(friends: [VKFriend]) {
        guard let realm = try? Realm() else { return }
        
        let existIds = friends.map({ $0.id })
        let friendsToDelete = realm.objects(RealmFriend.self).filter("NOT id IN %@", existIds)
        
        try? realm.write({
            realm.delete(friendsToDelete)
            friends.forEach { friend in
                let realmfriend = RealmFriend()
                realmfriend.id = friend.id
                realmfriend.firstName = friend.firstName
                realmfriend.lastName = friend.lastName
                realmfriend.nickname = friend.nickname
                realmfriend.sSizePhoto = friend.sSizePhoto
                realmfriend.mSizePhoto = friend.mSizePhoto
                realmfriend.xSizePhoto = friend.xSizePhoto
                realmfriend.trackCode = friend.trackCode
                realmfriend.sex = friend.sex
                
                if let city = friend.city {
                    let realmCity = RealmCity()
                    realmCity.id = city.id
                    realmCity.title = city.title
                    realmfriend.city = realmCity
                }
                
                if let lastSeen = friend.lastSeen {
                    realmfriend.lastSeen = lastSeen.time
                }
                
                realm.add(realmfriend, update: .all)
            }
        })
    }
}

extension Gate {
    func getGroups() async {
        let lastDateUpdate = UserDefaults.standard.integer(forKey: groupsKeyName)
        if needUpdate(lastDateUpdate) {
            guard let groups = try? await Networker.shared.getGroupsAsync(ownerId: Session.instance.userId) else { return }
            writeGroupsToRealm(groups: groups)
            UserDefaults.standard.set(Int(Date().timeIntervalSince1970), forKey: groupsKeyName)
        }
    }
    
    private func writeGroupsToRealm(groups: [VKGroup]) {
        guard let realm = try? Realm() else { return }
        
        let existIds = groups.map({ $0.id })
        let friendsToDelete = realm.objects(RealmGroup.self).filter("NOT id IN %@", existIds)
        
        var groupsToFirebase = [String]()
        
        try? realm.write({
            realm.delete(friendsToDelete)
            groups.forEach { group in
                let realmGroup = RealmGroup()
                realmGroup.id = group.id
                realmGroup.name = group.name
                realmGroup.screenName = group.screenName
                realmGroup.type = group.type
                realmGroup.sSizePhoto = group.sSizePhoto
                realmGroup.mSizePhoto = group.mSizePhoto
                realmGroup.lSizePhoto = group.lSizePhoto
                realmGroup.membersCount = group.membersCount
                realmGroup.desc = group.description
                realmGroup.status = group.status
                
                realm.add(realmGroup, update: .all)
                groupsToFirebase.append(String(group.id))
            }
        })
        
        db
            .collection(Resouces.Firebase.userCollectionName)
            .document(String(Session.instance.userId))
            .setData(["id": Session.instance.userId, "groups": groupsToFirebase], merge: true)
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return (lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate) / 1000
    }
}
