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
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @IBAction func Enter(_ sender: Any) {
        
        guard loginField.text != nil else {
            showAlert(title: "Ошибка входа", message: "Укажите логин", actions: [getRetryAction()])
            return
        }
        
        guard passwordField.text != nil else {
            showAlert(title: "Ошибка входа", message: "Укажите пароль", actions: [getRetryAction()])
            return
        }
        
        let login = loginField.text!
        let password = passwordField.text!
        
        if login.isEmpty || password.isEmpty {
            showAlert(
                title: "Ошибка входа",
                message: "Для входа необходимо заполнить логин и пароль!",
                actions: [getRetryAction()])
            return
        }
        
        if login == "admin" && password == "123" {
            showAlert(
                title: "Вход в приложение",
                message: "Вы вошли в систему",
                actions: [UIAlertAction(title: "Продолжить вход", style: UIAlertAction.Style.default, handler: { _ in print("Вход выполнен") })])
        } else {
            showAlert(
                title: "Вход в приложение",
                message: "Не верный логин или пароль",
                actions: [
                    getRetryAction(),
                    UIAlertAction(
                        title: "Закрыть приложение",
                        style: UIAlertAction.Style.cancel,
                        handler: { _ in exit(0)})])
        }
    }
    
    func getRetryAction() -> UIAlertAction {
        return UIAlertAction(title: "Повторить попытку", style: UIAlertAction.Style.default, handler: nil)
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        let buttonFrame: CGRect = enterButton.frame
        let info = notification.userInfo! as NSDictionary
        let keyboardFrame = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        
        if buttonFrame.origin.y <= keyboardFrame.origin.y {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.size.height, right: 0.0)
   
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView?.contentInset = UIEdgeInsets.zero
    }
    
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
}

