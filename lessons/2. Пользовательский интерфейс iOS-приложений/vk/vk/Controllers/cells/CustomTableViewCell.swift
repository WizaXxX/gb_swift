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
        
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageOfData.image = nil
        nameLabel.text = nil
        descLabel.text = nil
        numberOfDataLabel.text = nil
        
    }
        
    func configure(newId: Int?, newName: String?, newDesc: String?, NewNumberOfData: Int?, newImage: UIImage?) {
        id = newId
        nameLabel.text = newName
        descLabel.text = newDesc
        numberOfDataLabel.text = "\(NewNumberOfData ?? 0)"
        imageOfData.image = newImage
    }
    
}
