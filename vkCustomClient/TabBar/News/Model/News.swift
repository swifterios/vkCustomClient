//
//  News.swift
//  vkCustomClient
//
//  Created by Владислав on 30.06.2021.
//

import Foundation

struct NewsModel: Codable {
    let source_id: Int?
    let text: String?
    let likes: Likes
    let reposts: Reposts
    let attachments: [Attachments?]?
}

struct Likes: Codable {
    let count: Int
}

struct Reposts: Codable {
    let count: Int
}

struct Attachments: Codable {
    let type: String?
    let photo: Photo?
}

struct Photo: Codable {
    let owner_id: Int?
    let sizes: [Sizes?]
}

struct Sizes: Codable {
    let height: Int?
    let url: URL?
    let type: String?
    let width: Int?
}

struct NewsResponse<T: Codable>: Codable {
    let response: NewsResults<T>
}

struct NewsResults<T: Codable>: Codable {
    let items: [T]
}
