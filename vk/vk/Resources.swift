//
//  Resources.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//


public struct Resouces {
    
    struct Segue {
        static let fromVKLoginToMainBarController = "fromVKLoginToMainBarController"
        static let fromMyFriendsToFriend = "fromMyFriendsToFriend"
        static let fromMyGroupsToGroup = "fromMyGroupsToGroup"
    }
        
    struct CellIdentifiers {
        static let photoCollectionView = "photoCollectionViewCellIdentifier"
        static let friendTableView = "friendTableViewCellIdentifier"
        static let groupTableView = "GroupTableViewCellIdentifier"
    }
    
    struct Cell {
        static let photoCollectionViewCell = "PhotoCollectionViewCell"
        static let friendTableViewCell = "FriendTableViewCell"
        static let groupTableViewCell = "GroupTableViewCell"
    }
    
    struct VKAPI {
        static let clientId = "51393667"
        static let version = "5.131"
    }
}
