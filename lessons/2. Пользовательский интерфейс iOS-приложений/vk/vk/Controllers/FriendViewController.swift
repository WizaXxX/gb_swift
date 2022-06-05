//
//  FriendViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class FriendViewController: UIViewController {

//    @IBOutlet var navigationItem: UINavigationItem!
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var friend: Friend? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friend?.name
        friendImage.image = friend!.image
        ageLabel.text = "\(friend!.age)"
        nickNameLabel.text = friend!.nickName
        
    }
}
