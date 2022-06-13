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
    @IBOutlet weak var showHidePasswordButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.layer.cornerRadius = 6
        }
    }
    
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
    
    @IBAction func pressShowHidePassword(_ sender: Any) {
            
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        
        if passwordField.isSecureTextEntry {
            showHidePasswordButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .normal)
        } else {
            showHidePasswordButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        }
        
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
        
        let all_data = UserData()
        all_data.generateData()
        self.performSegue(withIdentifier: Resouces.Segue.fromLoginToMainBarController, sender: nil)
        
//        guard let login = loginField.text else {
//            loginField.showError()
//            return
//        }
//        if login.isEmpty {
//            loginField.showError()
//            return
//        }
//
//        guard let password = passwordField.text else {
//            passwordField.showError()
//            return
//        }
//        if password.isEmpty {
//            passwordField.showError()
//            return
//        }
//
//        showSpinner()
//        if login == "admin" && password == "123" {
//            let all_data = UserData()
//            all_data.generateData()
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.performSegue(withIdentifier: Resouces.Segue.fromLoginToMainBarController, sender: nil)
//                self.hideSpinner()
//            }
//
//        } else {
//            hideSpinner()
//            let alert = UIAlertController(
//                title: "Вход в приложение",
//                message: "Не верный логин или пароль",
//                preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Повторить попытку", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
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
