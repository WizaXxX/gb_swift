//
//  MyGroupsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyGroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let fromMyGroupsToAllGroups = "fromMyGroupsToAllGroups"
    let customTableViewCellIdentifier = "customTableViewCellIdentifier"
    let addGroupNotificationName = "addGroupNotificationName"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(groupAdded(_:)),
            name: Notification.Name(addGroupNotificationName),
            object: nil)
        
    }
    
    @objc func groupAdded(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func pressAddGroups(_ sender: Any) {
        performSegue(withIdentifier: fromMyGroupsToAllGroups, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: customTableViewCellIdentifier,
            for: indexPath) as! CustomTableViewCell
        
        let data = Data.myGroups[indexPath.row]
        cell.configure(newId: data.id, newName: data.name, newDesc: data.desc, NewNumberOfData: data.countOfPeople, newImage: data.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
        
        let group = Data.myGroups.first { $0.id == cell.id }
        let indexForDelete = Data.myGroups.firstIndex(where: { $0.id == cell.id })
        Data.myGroups.remove(at: indexForDelete!)
        Data.allGroups.append(group!)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

}
