//
//  ViewController.swift
//  vkCustomClient
//
//  Created by Владислав on 29.06.2021.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController {

    private var loginService: LoginService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            loginService = SceneDelegate.shared().loginService
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            loginService.wakeUpSession()
        } else {

        }
    }
}
