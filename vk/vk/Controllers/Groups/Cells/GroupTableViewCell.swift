//
//  GroupTableViewCell.swift
//  vk
//
//  Created by Илья Козырев on 04.08.2022.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var countOfMembers: UILabel!
    
    var group: VKGroup?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.imageView.image = nil
        name.text = nil
        countOfMembers.text = nil
    }
            
    func configure(from group: VKGroup) {
        self.group = group
        
        name.text = "\(group.name)"
        countOfMembers.text = "\(String(group.membersCount)) followers"
        avatarView.loadAndSetImage(from: group.mSizePhoto, cornerRadius: 30, shadowRadius: 10)        
    }
    
}
