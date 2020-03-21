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
    var userID: Int
    let retweetID: Int?
    let user: User
    let images: [Image]
    let likers: [Liker]
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
        user = (try? values.decode(User.self, forKey: .user)) ?? User.init(id: 0, nickname: "", image: nil)
        images = (try? values.decode([Image].self, forKey: .images)) ?? []
        likers = (try? values.decode([Liker].self, forKey: .likers)) ?? [Liker.init(id: 0, like: Like.init(createdAt: "", updatedAt: "", postID: 0, userID: 0))]
        retweet = (try? values.decode(Retweet.self, forKey: .retweet)) ?? nil //Retweet.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, retweetID: 0, user: RetweetUser.init(id: 0, nickname: ""), images: [Image.init(id: 0, src: "", createdAt: "", updatedAt: "", postID: 0, userID: 0)], comments: [Comment.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, postID: 0, user: User.init(id: 0, nickname: "", image: UserImage.init(src: "")))], likers: [Liker.init(id: 0, like: Like.init(createdAt: "", updatedAt: "", postID: 0, userID: 0))])
        comments = (try? values.decode([Comment].self, forKey: .comments)) ?? [Comment.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, postID: 0, user: User.init(id: 0, nickname: "", image: UserImage.init(src: "")), parentID: nil, reComment: [ReComment.init(id: 0, content: "", createdAt: "", updatedAt: "", userID: 0, postID: 0, user: User.init(id: 0, nickname: "", image: UserImage.init(src: "")), parentID: nil)])]
    }
}

struct Image: Codable {
    let id: Int
    let src, createdAt, updatedAt: String
    let postID: Int
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, src, createdAt, updatedAt
        case postID = "PostId"
        case userID = "UserId"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID, postID: Int
    let user: User
    let parentID: Int?
    let reComment: [ReComment]?

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case postID = "PostId"
        case parentID = "ParentId"
        case user = "User"
        case reComment = "ReComment"
    }
}

struct ReComment: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID, postID: Int
    let user: User
    let parentID: Int?

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case postID = "PostId"
        case parentID = "ParentId"
        case user = "User"
    }
}

// MARK: - Retweet
struct Retweet: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID: Int
    let retweetID: Int?
    let user: RetweetUser
    let images: [Image]
    let comments: [Comment]
    let likers: [Liker]

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case retweetID = "RetweetId"
        case user = "User"
        case images = "Images"
        case comments = "Comments"
        case likers = "Likers"
    }
}

// MARK: - Liker
struct Liker: Codable {
    let id: Int
    let like: Like

    enum CodingKeys: String, CodingKey {
        case id
        case like = "Like"
    }
}

// MARK: - Like
struct Like: Codable {
    let createdAt, updatedAt: String
    let postID, userID: Int

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case postID = "PostId"
        case userID = "UserId"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let nickname: String
    let image: UserImage?

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case image = "Image"
    }
}

struct RetweetUser: Codable {
    let id: Int
    let nickname: String
//    let image: UserImage?

    enum CodingKeys: String, CodingKey {
        case id, nickname
//        case image = "Image"
    }
}

struct UserImage: Codable {
    let src: String
}


typealias NewsPostsContent = [NewsPostsContentElement]
