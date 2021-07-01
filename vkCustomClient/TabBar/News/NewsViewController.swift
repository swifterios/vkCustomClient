//
//  NewsViewController.swift
//  vkCustomClient
//
//  Created by Владислав on 29.06.2021.
//

import Foundation
import UIKit
import Moya

protocol InformingDelegate {
    func valueChanged() -> [NewsModel]?
}

class NewsViewController: LoginViewController {
    
    let newsService = NewsService()
    var newsData: [NewsModel]?
    var delegate: InformingDelegate?
    
    
    func callFromOtherClass() {
        self.newsData = self.delegate?.valueChanged()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsService.getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(newsData) //  nil??
    }
}
