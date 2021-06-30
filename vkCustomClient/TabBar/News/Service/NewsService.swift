//
//  NewsService.swift
//  vkCustomClient
//
//  Created by Владислав on 30.06.2021.
//

import Foundation
import Moya

public enum NewsService {
    private static let accessToken =  "57f01a6e1fa55d69427c4f8530aa6e146981547bd7796563a2377691bca9f1b7b3d9d5ab718ec6ed46d4a"
    
    case getNewsFeed
}



// MARK: Moya extensions

extension NewsService: TargetType {
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
        
//        let authParameters = ["access_token:" : NewsService.accessToken]
        
        switch self {
        case .getNewsFeed:
            return .requestParameters(
                parameters: [
                    "access_token" : NewsService.accessToken,
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
