//
//  LikeView.swift
//  vk
//
//  Created by WizaXxX on 08.06.2022.
//

import UIKit

class LikeView: UIView {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var isLike: Bool = false
    var counter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    @IBAction func pressLikeButton(_ sender: Any) {
        
        isLike = !isLike
        if isLike {
            counter += 1
            imageView.image = UIImage(systemName: "heart.fill")
        }
        else {
            counter -= 1
            imageView.image = UIImage(systemName: "heart")
        }
        
        if counter == 0 {
            counterLabel.text = ""
        } else {
            counterLabel.text = String(counter)
        }
        
    }
    
    private func loadXIB() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: "LikeView", bundle: bundle)
        let xibView = xib.instantiate(withOwner: self).first as! UIView
        return xibView
    }
    
    private func setup() {
        
        let xibView = loadXIB()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        counterLabel.text = ""
    }

}
