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
    let id: Int?
    let content, createdAt, updatedAt: String?
    let isDeleted, isBlocked: Bool
    let userID: Int?
    let retweetID: Int?
    let user: User
    let images: [Image]
    let likers: [Liker]
    let retweet: Retweet?
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt,isDeleted, isBlocked
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
        isDeleted = (try? values.decode(Bool.self, forKey: .isDeleted)) ?? false
        isBlocked = (try? values.decode(Bool.self, forKey: .isBlocked)) ?? false
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? 0
        retweetID = (try? values.decode(Int.self, forKey: .retweetID)) ?? nil
        user = (try? values.decode(User.self, forKey: .user)) ?? User.init(id: 0, nickname: "", image: nil)
        images = (try? values.decode([Image].self, forKey: .images)) ?? []
        likers = (try? values.decode([Liker].self, forKey: .likers)) ?? [Liker.init(id: 0, like: Like.init(createdAt: "", updatedAt: "", postID: 0, userID: 0))]
        retweet = (try? values.decode(Retweet.self, forKey: .retweet)) ?? nil
        comments = (try? values.decode([Comment].self, forKey: .comments)) ?? [Comment.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, postID: 0, user: User.init(id: 0, nickname: "", image: UserImage.init(src: "")), parentID: nil, reComment: [ReComment.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, postID: 0, user: User.init(id: 0, nickname: "", image: UserImage.init(src: "")), parentID: nil)])]
    }
}

typealias UserPostContent = [UserPostContentElement]
