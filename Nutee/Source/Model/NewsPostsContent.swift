//
//  NewsPostsContent.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/03/01.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - NewsPostsContentElement
struct NewsPostsContentElement: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID: Int
    let retweetID: Int?
    let user: User
    let images: [String] // <--- String인지 확인필요
    let likers: [Int]
    let retweet: Retweet?
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case retweetID = "RetweetId"
        case user = "User"
        case images = "Images"
        case likers = "Likers"
        case retweet = "Retweet"
        case comments = "Comments"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
        updatedAt = (try? values.decode(String.self, forKey: .updatedAt)) ?? ""
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? 0
        retweetID = (try? values.decode(Int.self, forKey: .retweetID)) ?? nil
        user = (try? values.decode(User.self, forKey: .user)) ?? User.init(id: 0, nickname: "")
        images = (try? values.decode([String].self, forKey: .images)) ?? []
        likers = (try? values.decode([Int].self, forKey: .likers)) ?? []
        retweet = (try? values.decode(Retweet.self, forKey: .retweet)) ?? nil
        comments = (try? values.decode([Comment].self, forKey: .comments)) ?? [Comment.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, postID: 0, user: User.init(id: 0, nickname: ""))]
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID, postID: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case postID = "PostId"
        case user = "User"
    }
}

// MARK: - Retweet
struct Retweet: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID: Int
    let retweetID: Int?
    let user: User
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case retweetID = "RetweetId"
        case user = "User"
        case images = "Images"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let nickname: String
}

typealias NewsPostsContent = [NewsPostsContentElement]
