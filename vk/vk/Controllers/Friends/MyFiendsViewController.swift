//
//  MyFiendsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit
import RealmSwift

class MyFiendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var friends: Results<RealmFriend>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Обновить")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        connectTableToRealm()
        Task {
            await Gate.shared.getFriends()
        }
                
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
        
        guard let friend = sender as? Friend else {
            return
        }
        
        let view = segue.destination as! FriendViewController
        view.configure(friend: friend)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        Task {
            await Gate.shared.getFriends()
            refreshControl.endRefreshing()
        }
    }
}

extension MyFiendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.friendTableView,
            for: indexPath) as! FriendTableViewCell
        
        guard let realmFriend = friends?[indexPath.row] else { return cell }
        
        cell.configure(from: Friend(
            id: realmFriend.id,
            firstName: realmFriend.firstName,
            lastName: realmFriend.lastName,
            nickname: realmFriend.nickname,
            sSizePhoto: ImageFromVK(url: realmFriend.sSizePhoto),
            mSizePhoto: ImageFromVK(url: realmFriend.mSizePhoto),
            sex: realmFriend.sex,
            city: City(
                id: realmFriend.city?.id ?? 0,
                title: realmFriend.city?.title ?? ""),
            lastSeen: Date(timeIntervalSince1970: TimeInterval(realmFriend.lastSeen ?? 0))))
        
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

extension MyFiendsViewController {
    
    func connectTableToRealm() {
        guard let realm = try? Realm() else { return }
        friends = realm.objects(RealmFriend.self)
        token = friends?.observe( { [weak self] changes in
            switch changes {
            case .initial:
                self?.tableView.reloadData()
            case .error(let error): print(error)
            case let .update(_, deletions, insertions, modifications):
                DispatchQueue.main.async { [weak self] in
                    
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self?.tableView.endUpdates()
                    
                }
            }
        })
        
    }
}
