//
//  UserPostContent.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/29.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - UserPostContent
struct UserPostContentElement: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID: Int
    let retweetID: Int
    let user: UserPostUser
    let images, likers: [Int]

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case retweetID = "RetweetId"
        case user = "User"
        case images = "Images"
        case likers = "Likers"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
        updatedAt = (try? values.decode(String.self, forKey: .updatedAt)) ?? ""
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? 0
        retweetID = (try? values.decode(Int.self, forKey: .retweetID)) ?? 0
        user = (try? values.decode(UserPostUser.self, forKey: .user)) ?? UserPostUser.init(id: 0, nickname: "")
        images = (try? values.decode([Int].self, forKey: .images)) ?? []
        likers = (try? values.decode([Int].self, forKey: .likers)) ?? []
    }
}

// MARK: - User
struct UserPostUser: Codable {
    let id: Int
    let nickname: String
}

typealias UserPostContent = [UserPostContentElement]
