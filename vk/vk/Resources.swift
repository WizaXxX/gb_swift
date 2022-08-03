//
//  Resources.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//


public struct Resouces {
    
    struct Segue {
        static let fromLoginToMainBarController = "fromLoginToMainBarController"
        static let fromMyFriendsToFindFriends = "fromMyFriendsToFindFriends"
        static let fromMyGroupsToAllGroups = "fromMyGroupsToAllGroups"
        static let fromGroupListToGroup = "fromGroupListToGroup"
        static let fromFriendToPhoto = "fromFriendToPhoto"
        static let fromGroupMembersToFriend = "fromGroupMembersToFriend"
        static let fromVKLoginToMainBarController = "fromVKLoginToMainBarController"
        
        static let fromMyFriendsToFriend = "fromMyFriendsToFriend"
    }
    
    struct Notification {
        static let addFriend = "addFriendNotification"
        static let addGroup = "addGroupNotification"
    }
    
    struct CellIdentifiers {
        static let customTableView = "customTableViewCellIdentifier"
        static let photoCollectionView = "photoCollectionViewCellIdentifier"
        static let friendTableView = "friendTableViewCellIdentifier"
    }
    
    struct Cell {
        static let customTableViewCell = "CustomTableViewCell"
        static let photoCollectionViewCell = "PhotoCollectionViewCell"
        static let friendTableViewCell = "FriendTableViewCell"
    }
    
    struct VKAPI {
        static let clientId = "8216111"
        static let version = "5.131"
    }
}
