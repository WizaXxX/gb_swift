//
//  MyGroupsViewController.swift
//  vk
//
//  Created by WizaXxX on 30.05.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networker.shared.getGroups(ownerId: Session.instance.userId, completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        
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
        
        guard let group = sender as? VKGroup else {
            return
        }
        
        let view = segue.destination as! GroupViewController
        view.configure(group: group)
        
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.instance.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.groupTableView,
            for: indexPath) as! GroupTableViewCell
        
        let data = UserData.instance.groups[indexPath.row]
        cell.configure(from: data)
        
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
