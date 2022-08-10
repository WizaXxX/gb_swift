//
//  FriendTableViewCell.swift
//  vk
//
//  Created by Илья Козырев on 03.08.2022.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    var friend: Friend?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.imageView.image = nil
        name.text = nil
        city.text = nil
    }
            
    func configure(from friend: Friend) {
        self.friend = friend
        name.text = "\(friend.firstName) \(friend.lastName)"
        city.text = friend.city.title
        
        avatarView.loadAndSetImage(from: friend.sSizePhoto, cornerRadius: 30, shadowRadius: 10)        
    }
    
}
