//
//  FindFriendViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class FindFriendViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let delegate: AllDataDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(nibName: Resouces.Cell.customTableViewCell, bundle: nil),
            forCellReuseIdentifier: Resouces.CellIdentifiers.customTableView)
        
        tableView.dataSource = delegate
        tableView.delegate = delegate
        
        self.delegate.viewController = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.delegate = AllDataDelegate(manager: UserFriendsDataManager())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        self.delegate = AllDataDelegate(manager: UserFriendsDataManager())
        super.init(coder: coder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == Resouces.Segue.fromFriendListToFriend else {
            return
        }
        let friend = sender as! Friend
        let view = segue.destination as! FriendViewController
        view.friend = friend
    }
    
}
