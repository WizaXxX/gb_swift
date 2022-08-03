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
    
    var friend: VKFriend?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.imageView.image = nil
        name.text = nil
        city.text = nil
    }
            
    func configure(from friend: VKFriend) {
        self.friend = friend
        name.text = "\(friend.firstName) \(friend.lastName)"
        city.text = friend.city?.title
        
        guard let url = URL(string: friend.sSizePhoto) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        avatarView.imageView.image = UIImage(data: imageData)
        avatarView.clipsToBounds = false
        avatarView.layer.cornerRadius = 30
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOffset = CGSize(width: 5, height: 5)
        avatarView.layer.shadowRadius = 10
        avatarView.layer.shadowOpacity = 0.7
        avatarView.backgroundColor = .white

        avatarView.imageView.clipsToBounds = true
        avatarView.imageView.layer.cornerRadius = avatarView.layer.cornerRadius
        
    }
    
}
