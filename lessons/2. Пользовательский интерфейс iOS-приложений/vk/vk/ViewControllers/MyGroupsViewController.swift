//
//  MyGroupsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {
    
    let fromMyGroupsToAllGroups = "fromMyGroupsToAllGroups"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressAddGroups(_ sender: Any) {
        performSegue(withIdentifier: fromMyGroupsToAllGroups, sender: nil)
    }

}
