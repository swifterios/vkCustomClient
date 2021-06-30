//
//  SceneDelegate.swift
//  vkCustomClient
//
//  Created by Владислав on 29.06.2021.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var loginService: LoginService!
    
    @available(iOS 13.0, *)
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = (scene?.delegate as? SceneDelegate)!
        return sd
    }

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }

        loginService = LoginService()
        loginService.delegate = self
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) { }
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {}
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {}
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {}
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {}
}


extension SceneDelegate: AuthServiceDelegate {
    func authServiceShootShow(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true)
    }
    
    
    func authServiceSignIn() {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarVierController = storyboard.instantiateViewController(identifier: "TabBar")
        window?.rootViewController = tabBarVierController
        print("AUTH")
    }
    
    func authServiceSignInDidFail() {
        print("ERROR")
    }
}

