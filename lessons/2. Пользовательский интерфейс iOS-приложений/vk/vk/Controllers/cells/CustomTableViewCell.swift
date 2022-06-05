//
//  CustomTableViewCell.swift
//  vk
//
//  Created by WizaXxX on 01.06.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageOfData: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var numberOfDataLabel: UILabel!
    
    var id: Int? = nil
    var data: CommonUserData?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageOfData.image = nil
        nameLabel.text = nil
        descLabel.text = nil
        numberOfDataLabel.text = nil
        
    }
            
    func configure(_ userData: CommonUserData) {
        data = userData
        nameLabel.text = userData.name
        descLabel.text = userData.getDescription()
        numberOfDataLabel.text = "\(userData.getNumbersData())"
        imageOfData.image = userData.image
    }
    
}
