//
//  MyFiendsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyFiendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let fromMyFriendsToFindFriends = "fromMyFriendsToFindFriends"
    let fromMyFriendToFriend = "fromMyFriendToFriend"
    let customTableViewCellIdentifier = "customTableViewCellIdentifier"
    let addFriendNotificationName = "addNotificationName"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: customTableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(friendAdded(_:)),
            name: Notification.Name(addFriendNotificationName),
            object: nil)
    }
    
    @objc func friendAdded(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func pressAddFriends(_ sender: Any) {
        performSegue(withIdentifier: fromMyFriendsToFindFriends, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.myFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: customTableViewCellIdentifier,
            for: indexPath) as! CustomTableViewCell
        
        let data = Data.myFriends[indexPath.row]
        cell.configure(newId: data.id, newName: data.name, newDesc: data.nickName, NewNumberOfData: data.age, newImage: data.image)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
        let friend = Data.myFriends.first { $0.id == cell.id }
        performSegue(withIdentifier: fromMyFriendToFriend, sender: friend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == fromMyFriendToFriend else {
            return
        }
        let friend = sender as! Friend
        let view = segue.destination as! FriendViewController
        view.friend = friend
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
        
        let friend = Data.myFriends.first { $0.id == cell.id }
        let indexForDelete = Data.myFriends.firstIndex(where: { $0.id == cell.id })
        Data.myFriends.remove(at: indexForDelete!)
        Data.allFriends.append(friend!)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
