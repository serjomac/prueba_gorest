//
//  Post.swift
//  testgorest
//
//  Created by Jonathan Macias on 17/6/22.
//

import Foundation

struct PostResponse: Codable {
    var meta: Meta
    var data: [Post]
}

struct Meta: Codable {
    var pagination: Pagination
}

struct Pagination: Codable {
    var total: Int
    var pages: Int
    var page: Int
    var limit: Int?
    var links: Link
}

struct Link: Codable {
    var previous: String?
    var current: String?
    var next: String?
}

struct Post: Codable {
    var id: Int
    var userId: Int
    var title: String
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case userId = "user_id"
        case description = "body"
    }
}
