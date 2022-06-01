//
//  FindFriendViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class FindFriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let customTableViewCellIdentifier = "customTableViewCellIdentifier"
    let addFriendNotificationName = "addNotificationName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.allFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: customTableViewCellIdentifier,
            for: indexPath) as! CustomTableViewCell
        
        let data = Data.allFriends[indexPath.row]
        cell.configure(newId: data.id, newName: data.name, newDesc: data.nickName, NewNumberOfData: data.age, newImage: data.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
                
        let friend = Data.allFriends.first { $0.id == cell.id }
        let indexForDelete = Data.allFriends.firstIndex(where: { $0.id == cell.id })
        Data.allFriends.remove(at: indexForDelete!)
        Data.myFriends.append(friend!)
        tableView.deleteRows(at: [indexPath], with: .fade)
        NotificationCenter.default.post(name: Notification.Name(addFriendNotificationName), object: nil)
    }
    
}
