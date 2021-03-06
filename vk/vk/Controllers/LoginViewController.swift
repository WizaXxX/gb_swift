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
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var pinkView: UIView!
    @IBOutlet weak var tealView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        progressView.isHidden = true
        purpleView.layer.cornerRadius = 25
        purpleView.alpha = 0
        pinkView.layer.cornerRadius = 25
        pinkView.alpha = 0
        tealView.layer.cornerRadius = 25
        pinkView.alpha = 0
        
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
    
    private func startLogin(_ maxNumbersOfCircle: Int = 1, numberOfCircle: Int = 1) {
        
        if numberOfCircle == 1 {
            showHidePasswordButton.isHidden = true
            enterButton.isEnabled = false
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [.curveEaseIn]) { [weak self] in
                    let moveTo = (self?.scrollView.frame.size.width)! + 100
                    
                    let translationForLogin = CGAffineTransform(translationX: moveTo, y: 0)
                    self?.loginField.transform = translationForLogin
                    
                    let translationForPass = CGAffineTransform(translationX: -moveTo, y: 0)
                    self?.passwordField.transform = translationForPass
                    
                } completion: { _ in
                }
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 0.2,
                initialSpringVelocity: 5,
                options: []) { [weak self] in
                    let height: CGFloat = (self?.scrollView.frame.size.height)!
                    let buttonPosition: CGFloat = (self?.enterButton.frame.origin.y)!
                    let moveTo = (height - buttonPosition) - (self?.enterButton.frame.size.height)!
                    let transformation = CGAffineTransform(translationX: 0, y: moveTo)
                    self?.enterButton.transform = transformation
                } completion: { _ in
                }

        }
        
        progressView.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.purpleView.alpha = 1
            self?.pinkView.alpha = 0
            self?.tealView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.purpleView.alpha = 0
                self?.pinkView.alpha = 1
                self?.tealView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.purpleView.alpha = 0
                    self?.pinkView.alpha = 0
                    self?.tealView.alpha = 1
                } completion: {[weak self] _ in
                    
                    if numberOfCircle == maxNumbersOfCircle {
                        Session.instance.token = UUID().uuidString
                        Session.instance.userId = Int.random(in: (0...Int.max))
                        print("?????????? ????????????????????????: \(Session.instance.token)")
                        print("???? ????????????????????????: \(Session.instance.userId)")
                        self?.performSegue(withIdentifier: Resouces.Segue.fromLoginToMainBarController, sender: nil)
                    } else {
                        self?.startLogin(
                            maxNumbersOfCircle,
                            numberOfCircle: numberOfCircle + 1)
                    }
                    
                }
            }
        }

        
    }
    
    @IBAction func Enter(_ sender: Any) {
        
        guard let login = loginField.text else {
            loginField.showError()
            return
        }
        if login.isEmpty {
            loginField.showError()
            return
        }

        guard let password = passwordField.text else {
            passwordField.showError()
            return
        }
        if password.isEmpty {
            passwordField.showError()
            return
        }

        if login == "admin" && password == "123" {
            let all_data = UserData()
            all_data.generateData()

            startLogin()

        } else {
            let alert = UIAlertController(
                title: "???????? ?? ????????????????????",
                message: "???? ???????????? ?????????? ?????? ????????????",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "?????????????????? ??????????????", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        let buttonFrame: CGRect = enterButton.frame
        let info = notification.userInfo! as NSDictionary
        let keyboardFrame = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        
        if buttonFrame.origin.y <= keyboardFrame.origin.y {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.size.height, right: 0.0)
   
        // ?????????????????? ???????????? ?????????? UIScrollView, ???????????? ?????????????? ????????????????????
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
