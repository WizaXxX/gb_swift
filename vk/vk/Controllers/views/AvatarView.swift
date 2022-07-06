//
//  AvatarViewController.swift
//  vk
//
//  Created by WizaXxX on 08.06.2022.
//

import UIKit

class AvatarView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        setup()
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func loadXIB() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "AvatarView", bundle: bundle)
        let xibView = xib.instantiate(withOwner: self).first as! UIView
        return xibView
    }
    
    private func setup() {
        
        let xibView = loadXIB()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }

}
