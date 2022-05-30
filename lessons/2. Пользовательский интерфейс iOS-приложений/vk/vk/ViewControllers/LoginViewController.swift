//
//  ViewController.swift
//  vk
//
//  Created by WizaXxX on 20.05.2022.
//

import UIKit
import Security

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let fromLoginToMainBarController = "fromLoginToMainBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        hideSpinner()
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
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        
        loginField.isEnabled = false
        passwordField.isEnabled = false
        enterButton.isEnabled = false
    }
    
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
        
        loginField.isEnabled = true
        passwordField.isEnabled = true
        enterButton.isEnabled = true
    }
    
    @IBAction func Enter(_ sender: Any) {
        
        guard let login = loginField.text else {
            showError("Укажите логин")
            return
        }
        if login.isEmpty {
            showError("Укажите логин")
            return
        }
        
        guard let password = passwordField.text else {
            showError("Укажите пароль")
            return
        }
        if password.isEmpty {
            showError("Укажите пароль")
            return
        }
                
        if login == "admin" && password == "123" {
            
            showSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: self.fromLoginToMainBarController, sender: nil)
                self.hideSpinner()
            }
            
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
    
    func showError(_ message: String) {
        showAlert(title: "Ошибка входа", message: message, actions: [getRetryAction()])
    }
    
    func getRetryAction() -> UIAlertAction {
        return UIAlertAction(title: "Повторить попытку", style: UIAlertAction.Style.default, handler: nil)
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        hideSpinner()
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
