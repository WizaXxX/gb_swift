//
//  CommonViewControllerDelegate.swift
//  vk
//
//  Created by WizaXxX on 05.06.2022.
//

import UIKit

class MyDataDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var viewController: UIViewController?
    var manager: DataManager
    
    init(manager: DataManager) {
        self.manager = manager
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.countOfMyData
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Resouces.CellIdentifiers.customTableView,
            for: indexPath) as! CustomTableViewCell
        
        let data = manager.getFromMyData(at: indexPath.row)
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
        
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
        
        guard let data = cell.data else {
            return
        }
        
        manager.moveFromMyDataToAllData(data: data)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
