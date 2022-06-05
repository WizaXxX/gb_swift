//
//  MyGroupsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let delegate: MyDataDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: Resouces.CellIdentifiers.customTableView)
        tableView.dataSource = delegate
        tableView.delegate = delegate
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(groupAdded(_:)),
            name: Notification.Name(Resouces.Notification.addGroup),
            object: nil)
        
        self.delegate.viewController = self
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.delegate = MyDataDelegate(manager: UserGroupsDataManager())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        self.delegate = MyDataDelegate(manager: UserGroupsDataManager())
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func groupAdded(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func pressAddGroups(_ sender: Any) {
        performSegue(withIdentifier: Resouces.Segue.fromMyGroupsToAllGroups, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == Resouces.Segue.fromGroupListToGroup else {
            return
        }
        let group = sender as! Group
        let view = segue.destination as! GroupViewController
        view.group = group
    }
    
}
