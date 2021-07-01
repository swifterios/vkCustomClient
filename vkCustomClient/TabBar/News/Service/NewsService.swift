//
//  NewsService.swift
//  vkCustomClient
//
//  Created by Владислав on 30.06.2021.
//

import Foundation
import Moya


class NewsService: InformingDelegate {

    let provider = MoyaProvider<News>()
    var newsData: [NewsModel]?

    func valueChanged() -> [NewsModel]? {
        return newsData
    }
    
    private var state: State = .loading {
        didSet {
            switch state {
            case .ready: print(".ready")
            case .loading: print(".loading")
            case .error: print(".error")
            }
        }
    }
    
    public func getNews() {
        
        provider.request(.getNewsFeed) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                
                do {
                    self.state = .ready(try response.map(NewsResponse<NewsModel>.self).response.items)
                } catch  {
                    self.state = .error
                    print(error)
                }
                
                guard case .ready(let items) = self.state else { return }
                self.newsData = items
                
                
                let newsViewController: NewsViewController = NewsViewController()
                newsViewController.delegate = self
                newsViewController.callFromOtherClass()
                
                
            case .failure:
                print("failure")
                self.state = .error
            }
        }
    }
}



// MARK: Moya enums

public enum News {
    static let accessToken =  UserDefaults.standard.string(forKey: "userToken")!
    
    case getNewsFeed
}



// MARK: Moya extensions

extension News: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.vk.com/method")!
    }
    
    public var path: String {
        switch self {
        case .getNewsFeed: return "/newsfeed.get"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getNewsFeed: return .get
        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getNewsFeed:
            return .requestParameters(
                parameters: [
                    "access_token" : News.accessToken,
                    "filters" : "post",
                    "v" : "5.131",
                ], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

extension NewsService {
    enum State {
        case loading
        case ready([NewsModel])
        case error
    }
}
