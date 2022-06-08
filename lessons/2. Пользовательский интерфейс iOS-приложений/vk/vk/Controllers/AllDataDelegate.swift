//
//  AllDataDelegate.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//

import UIKit

class AllDataDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {

    weak var viewController: UIViewController?
    var manager: DataManager
    
    init(manager: DataManager) {
        self.manager = manager
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.countOfAllData
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.customTableView,
            for: indexPath) as! CustomTableViewCell
        
        let data = manager.getFromAllData(at: indexPath.row)
        cell.configure(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
        
        guard let data = cell.data else {
            return
        }
        
        if let segueIdentifier = data.segueFromItemListToItem() {
            viewController?.performSegue(withIdentifier: segueIdentifier, sender: data)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: manager.addActionName()) { [weak self] (action, view, completionHandler) in
            guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
                return
            }
            guard let data = cell.data else {
                return
            }
            self?.manager.moveFromAllDataToMyData(data: data)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        action.backgroundColor = .systemBlue
    
        return UISwipeActionsConfiguration(actions: [action])
    }
}
