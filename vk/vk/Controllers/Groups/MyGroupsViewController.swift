//
//  MyGroupsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit
import RealmSwift

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var groups: Results<RealmGroup>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Обновить")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        connectTableToRealm()
        Task {
            await Gate.shared.getGroups()
        }
        
        tableView.register(
            UINib(nibName: Resouces.Cell.groupTableViewCell, bundle: nil),
            forCellReuseIdentifier: Resouces.CellIdentifiers.groupTableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == Resouces.Segue.fromMyGroupsToGroup else {
            return
        }
        
        guard let group = sender as? Group else {
            return
        }
        
        let view = segue.destination as! GroupViewController
        view.configure(group: group)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        Task {
            await Gate.shared.getGroups()
            refreshControl.endRefreshing()
        }
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.groupTableView,
            for: indexPath) as! GroupTableViewCell
        
        guard let realmGroup = groups?[indexPath.row] else { return cell }
        cell.configure(from: Group(
            id: realmGroup.id,
            name: realmGroup.name,
            mSizePhoto: ImageFromVK(url: realmGroup.mSizePhoto),
            membersCount: realmGroup.membersCount,
            description: realmGroup.desc,
            status: realmGroup.status))
        
        return cell
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GroupTableViewCell else { return }
        guard let data = cell.group else { return }

        performSegue(withIdentifier: Resouces.Segue.fromMyGroupsToGroup, sender: data)
    }
}

extension MyGroupsViewController {
    
    func connectTableToRealm() {
        guard let realm = try? Realm() else { return }
        groups = realm.objects(RealmGroup.self)
        token = groups?.observe( { [weak self] changes in
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
