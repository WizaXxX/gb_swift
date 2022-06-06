//
//  PhotoViewerUIViewController.swift
//  vk
//
//  Created by WizaXxX on 06.06.2022.
//

import UIKit

class PhotoViewerUIViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    func configure(image: UIImage) {
        self.image = image
    }

}
