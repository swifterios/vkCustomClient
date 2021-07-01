//
//  LoginService.swift
//  vkCustomClient
//
//  Created by Владислав on 30.06.2021.
//

import Foundation
import UIKit
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShootShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}


class LoginService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7891344"
    private let vkSdk: VKSdk
    weak var delegate: AuthServiceDelegate?
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.uiDelegate = self
        vkSdk.register(self)
    }
    
    
    func wakeUpSession() {
        let scope = ["wall", "friends", "photos", "offline"]
        
        VKSdk.wakeUpSession(scope) { [weak self] (state, erorr) in
            guard let self = self else { return }
            
            if state == .initialized {
                VKSdk.authorize(scope)
            }
            
            if state == .authorized {
                self.delegate?.authServiceSignIn()
                
                let token = VKSdk.accessToken().accessToken!
                UserDefaults.standard.setValue(token as String, forKey: "userToken")
            } else {
                self.delegate?.authServiceSignInDidFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            let res = result.token!
            UserDefaults.standard.setValue(res, forKey: "userToken")
            //print(UserDefaults.standard.value(forKey: "userToken"))
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShootShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {}

}
