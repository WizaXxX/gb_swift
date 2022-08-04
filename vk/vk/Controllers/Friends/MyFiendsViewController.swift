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
        
        tableView.register(
            UINib(nibName: Resouces.Cell.friendTableViewCell, bundle: nil),
            forCellReuseIdentifier: Resouces.CellIdentifiers.friendTableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == Resouces.Segue.fromMyFriendsToFriend else {
            return
        }
        
        guard let friend = sender as? VKFriend else {
            return
        }
        
        let view = segue.destination as! FriendViewController
        view.configure(friend: friend)
        
    }
}

extension MyFiendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.instance.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.friendTableView,
            for: indexPath) as! FriendTableViewCell
        
        let data = UserData.instance.friends[indexPath.row]
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
}
