//
//  MyFiendsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyFiendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let delegate: MyDataDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Networker.shared.getFriends()
        Networker.shared.getPhotos(ownerId: String(Session.instance.userId))
        Networker.shared.getGroups()
        Networker.shared.searchGoups(query: "MDK")
        
        tableView.register(
            UINib(nibName: Resouces.Cell.customTableViewCell, bundle: nil),
            forCellReuseIdentifier: Resouces.CellIdentifiers.customTableView)
        
        tableView.dataSource = delegate
        tableView.delegate = delegate
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(friendAdded(_:)),
            name: Notification.Name(Resouces.Notification.addFriend),
            object: nil)
        
        self.delegate.viewController = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.delegate = MyDataDelegate(manager: UserFriendsDataManager())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        self.delegate = MyDataDelegate(manager: UserFriendsDataManager())
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func friendAdded(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func pressAddFriends(_ sender: Any) {
        performSegue(withIdentifier: Resouces.Segue.fromMyFriendsToFindFriends, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let friend = sender as? Friend {
            friend.prepareSegue(segue: segue)
        }
    }
}
