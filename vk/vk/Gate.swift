//
//  Gate.swift
//  vk
//
//  Created by Илья Козырев on 08.08.2022.
//

import Foundation
import RealmSwift

enum ErrorType: Error {
    case CantCreateRealm
}

class Gate {
    private init() {}
    static let shared = Gate()
    
    var friendsLastUpdateTime: Date?
    var groupsLasUpdateTime: Date?
    
    private func needUpdate(_ checkDate: Date?) -> Bool {
        guard let lastUpdateDate = checkDate else { return true }
        let currentDate = Date()
        
        return ((currentDate - lastUpdateDate) / 60) > 60 // Обновляем если прошло больше 60 сек
        
    }
}

extension Gate {

    func getFriends() async {

        if needUpdate(friendsLastUpdateTime) {
            guard let friends = try? await Networker.shared.getFriendAsync() else { return }
            writeFriendsToRealm(friends: friends)
        }
        try? getFriendFromRealm()
    }
    
    private func writeFriendsToRealm(friends: [VKFriend]) {
        guard let realm = try? Realm() else { return }
        try? realm.write({
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
    
    private func getFriendFromRealm() throws {
        try? Realm().objects(RealmFriend.self).forEach { realmFriend in
            UserData.instance.friends.append(Friend(
                id: realmFriend.id,
                firstName: realmFriend.firstName,
                lastName: realmFriend.lastName,
                nickname: realmFriend.nickname,
                sSizePhoto: realmFriend.sSizePhoto,
                mSizePhoto: realmFriend.mSizePhoto,
                sex: realmFriend.sex,
                city: City(
                    id: realmFriend.city?.id ?? 0,
                    title: realmFriend.city?.title ?? ""),
                lastSeen: Date(timeIntervalSince1970: TimeInterval(realmFriend.lastSeen ?? 0))))
        }
    }
}

extension Gate {
    func getGroups() async {
        if needUpdate(groupsLasUpdateTime) {
            guard let groups = try? await Networker.shared.getGroupsAsync(ownerId: Session.instance.userId) else { return }
            writeGroupsToRealm(groups: groups)
        }
        
        try? getGroupFromRealm()
    }
    
    private func writeGroupsToRealm(groups: [VKGroup]) {
        guard let realm = try? Realm() else { return }
        try? realm.write({
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
            }
        })
    }
    
    private func getGroupFromRealm() throws {
        try? Realm().objects(RealmGroup.self).forEach { realmGroup in
            UserData.instance.groups.append(Group(
                id: realmGroup.id,
                name: realmGroup.name,
                mSizePhoto: realmGroup.mSizePhoto,
                membersCount: realmGroup.membersCount,
                description: realmGroup.desc,
                status: realmGroup.status))
        }
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return (lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate) / 1000
    }
}
