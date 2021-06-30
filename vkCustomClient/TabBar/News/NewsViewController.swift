//
//  NewsViewController.swift
//  vkCustomClient
//
//  Created by Владислав on 29.06.2021.
//

import Foundation
import UIKit
import Moya

class NewsViewController: LoginViewController {
    
    let provider = MoyaProvider<NewsService>()
    
    private var state: State = .loading {
      didSet {
        switch state {
        case .ready: print(".ready")
        case .loading: print(".loading")
        case .error: print(".error")
        }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .loading
        
        provider.request(.getNewsFeed) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
        
            case .success(let responce):
                
                do {
                    print(try responce.mapJSON())
                } catch  {
                    self.state = .error
                    print("catch error")
                }
                
            case .failure:
                print("failure")
                self.state = .error
            }
        }
    }
}

extension NewsViewController {
    enum State {
        case loading
        case ready
        case error
    }
}
