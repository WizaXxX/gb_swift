//
//  MyFiendsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyFiendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networker.shared.getFriends(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        
//        Networker.shared.getPhotos(ownerId: String(Session.instance.userId))
//        Networker.shared.getGroups()
//        Networker.shared.searchGoups(query: "MDK")
        
        tableView.register(
            UINib(nibName: Resouces.Cell.friendTableViewCell, bundle: nil),
            forCellReuseIdentifier: Resouces.CellIdentifiers.friendTableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(friendAdded(_:)),
            name: Notification.Name(Resouces.Notification.addFriend),
            object: nil)
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
        
        guard segue.identifier == Resouces.Segue.fromMyFriendsToFriend else {
            return
        }
        
        guard let friend = sender as? VKFriend else {
            return
        }
        
        let view = segue.destination as! VKFriendViewController
        view.configure(friend: friend)
        
    }
}

extension MyFiendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VKUserData.instance.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.friendTableView,
            for: indexPath) as! FriendTableViewCell
        
        let data = VKUserData.instance.friends[indexPath.row]
        cell.configure(from: data)
        
        return cell
    }
}

extension MyFiendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendTableViewCell else { return }
        guard let data = cell.friend else { return }

        performSegue(withIdentifier: Resouces.Segue.fromMyFriendsToFriend, sender: data)
    }
        
   
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete else {
//            return
//        }
//
//        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
//            return
//        }
//
//        guard let data = cell.data else {
//            return
//        }
//
//        manager.moveFromMyDataToAllData(data: data)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }
    
}
