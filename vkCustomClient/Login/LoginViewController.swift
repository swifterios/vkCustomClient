//
//  ViewController.swift
//  vkCustomClient
//
//  Created by Владислав on 29.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
//    @IBAction func loginButton(_ sender: UIButton) {
//
//    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        
        if #available(iOS 13.0, *) {
            let tabbarVC = storyboard.instantiateViewController(identifier: "TabBar")
            navigationController?.pushViewController(tabbarVC, animated: true)
        } else {
            // Fallback on earlier versions
            print("HELLO 10.0+")
        }
    }
    
}

