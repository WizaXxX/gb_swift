//
//  ViewController.swift
//  vk
//
//  Created by WizaXxX on 20.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Enter(_ sender: Any) {
        let login = loginField.text!
        let password = passwordField.text!
        
        if login.isEmpty || password.isEmpty {
            showAlert(
                title: "Ошибка входа",
                message: "Для входа необходимо заполнить логин и пароль!",
                actions: [UIAlertAction(title: "Повторить попытку", style: UIAlertAction.Style.default, handler: nil)])
            return
        }
        
        showAlert(
            title: "Вход в систему",
            message: "Вы пытаетесь войти под пользователем \(login) c паролем \(password)",
            actions: [
                UIAlertAction(title: "Продолжить вход", style: UIAlertAction.Style.default, handler: { _ in print("Вход выполнен") }),
                UIAlertAction(title: "Отменить", style: UIAlertAction.Style.cancel, handler: { _ in print("Вход отменен")})],
            needActions: true)
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction], needActions: Bool = false) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

