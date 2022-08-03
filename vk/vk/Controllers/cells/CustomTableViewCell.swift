//
//  CustomTableViewCell.swift
//  vk
//
//  Created by WizaXxX on 01.06.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    var id: Int? = nil
    var data: CommonUserData?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.imageView.image = nil
        nameLabel.text = nil
        descLabel.text = nil
    }
            
    func configure(_ userData: CommonUserData) {
        data = userData
        nameLabel.text = userData.name
        descLabel.text = userData.getDescription()
        
        avatarView.imageView.image = userData.image
        avatarView.clipsToBounds = false
        avatarView.layer.cornerRadius = 20
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOffset = CGSize(width: 5, height: 5)
        avatarView.layer.shadowRadius = 10
        avatarView.layer.shadowOpacity = 0.7
        avatarView.backgroundColor = .white

        avatarView.imageView.clipsToBounds = true
        avatarView.imageView.layer.cornerRadius = avatarView.layer.cornerRadius
        
    }
    
}
