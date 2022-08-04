//
//  GroupViewController.swift
//  vk
//
//  Created by Илья Козырев on 04.08.2022.
//

import UIKit

class GroupViewController: UIViewController {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var fullDesc: UITextView!
    
    var group: VKGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentGroup = group else { return }
        
        name.text = currentGroup.name
        desc.text = currentGroup.status
        fullDesc.text = currentGroup.description
        avatarView.loadAndSetImage(from: currentGroup.mSizePhoto, cornerRadius: 50, shadowRadius: 5)
    }
    
    func configure(group: VKGroup) {
        self.group = group
    }
}
