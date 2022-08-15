//
//  WKWebViewController.swift
//  vk
//
//  Created by Илья Козырев on 11.07.2022.
//

import UIKit
import WebKit
import SwiftKeychainWrapper
import CryptoKit
import FirebaseFirestore

class WKWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    private let tokenKeyName = "token"
    private let userIdKeyName = "userId"
    private let tokenExpiresInDateKeyName = "tokenExpiresInDate"
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        webView.navigationDelegate = self
        
        if needReloadToken() {
            loadLoginPage()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Session.instance.token != "" {
            performSegue(withIdentifier: Resouces.Segue.fromVKLoginToMainBarController, sender: nil)
        }
    }
    
    func loadLoginPage() {
       
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: Resouces.VKAPI.clientId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: Resouces.VKAPI.version)
        ]

        guard let url = urlComponents?.url else { return }
        print(url)
        let request = URLRequest(url: url)

        webView.load(request)
    }
    
    private func needReloadToken() -> Bool {
        
        guard let token = KeychainWrapper.standard.string(forKey: tokenKeyName) else { return true }
        
        let userId = UserDefaults.standard.integer(forKey: userIdKeyName)
        if userId == 0 {
            return true
        }
        
        let tokenExpiresDate = UserDefaults.standard.integer(forKey: tokenExpiresInDateKeyName)
        if tokenExpiresDate == 0 {
            return true
        }
        
        let dateNow = Date()
        if tokenExpiresDate <= Int(dateNow.timeIntervalSince1970) {
            return true
        }
        
        setSessionData(token: token, userId: userId)
        
        return false
    }
    
    private func saveAuthData(expiresInSecond: Int) {
        KeychainWrapper.standard.set(Session.instance.token, forKey: tokenKeyName)
        UserDefaults.standard.set(Session.instance.userId, forKey: userIdKeyName)
        
        let dateNow = Date()
        let expiresIn = Int(dateNow.timeIntervalSince1970) + expiresInSecond
        
        UserDefaults.standard.set(expiresIn, forKey: tokenExpiresInDateKeyName)
    }
    
    private func setSessionData(token: String, userId: Int) {
        Session.instance.token = token
        Session.instance.userId = userId
                
        db
            .collection(Resouces.Firebase.userCollectionName)
            .document(String(userId))
            .setData(["id": userId], merge: true)
    }
    
}

extension WKWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)

        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else { return }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String : String](), { partialResult, param in
                var dict = partialResult
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })
        
        guard let token = params["access_token"] else {
            let alert = UIAlertController(
                title: "Ошибка получения токена",
                message: "Повторите попытку авторизации",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Повторить", style: UIAlertAction.Style.default))
            present(alert, animated: true, completion: nil)
            
            loadLoginPage()
            return
        }
        
        var id = 0
        if let userId = params["user_id"] {
            if let userIdInt = Int(userId) {
                id = userIdInt
            }
        }
        
        setSessionData(token: token, userId: id)
        
        if let expiresInSecond = params["expires_in"] {
            if let expiresInSecondInt = Int(expiresInSecond) {
                saveAuthData(expiresInSecond: expiresInSecondInt)
            }
        }
        
        performSegue(withIdentifier: Resouces.Segue.fromVKLoginToMainBarController, sender: nil)
    }
}
