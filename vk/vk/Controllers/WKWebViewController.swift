//
//  WKWebViewController.swift
//  vk
//
//  Created by Илья Козырев on 11.07.2022.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        loadLoginPage()
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
        Session.instance.token = token
        
        if let userId = params["user_id"] {
            if let userIdInt = Int(userId) {
                Session.instance.userId = userIdInt
            }
        }
        
        performSegue(withIdentifier: Resouces.Segue.fromVKLoginToMainBarController, sender: nil)
    }
}
