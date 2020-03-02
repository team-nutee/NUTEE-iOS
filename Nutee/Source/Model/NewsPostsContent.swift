//
//  PostsContent.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/03/01.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - PostsContentElement
struct PostsContentElement: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID: Int
    let retweetID: Int?
    let user: User
    let images: String // <--- String인지 확인필요
    let likers: Int
    let retweet: Comment?
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
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let content, createdAt, updatedAt: String
    let userID: Int
    let postID: Int?
    let user: User
    let retweetID: Int
    let images: String // <--- String인지 확인필요

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, updatedAt
        case userID = "UserId"
        case postID = "PostId"
        case user = "User"
        case retweetID = "RetweetId"
        case images = "Images"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let nickname: String
}

//enum Nickname: String, Codable {
//    case qq = "qq"
//    case test = "test"
//    case test001 = "test001"
//    case test2 = "test2"
//}

typealias PostsContent = [PostsContentElement]
