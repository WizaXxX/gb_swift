//
//  PhotoCollectionViewCell.swift
//  vk
//
//  Created by WizaXxX on 06.06.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeView: LikeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }

}
