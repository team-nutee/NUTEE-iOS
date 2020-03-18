//
//  SignIn.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/13.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - SignIn
struct SignIn: Codable {
    let id: Int
    let nickname, userID: String
    let posts: [Post]
    let followings, followers: [FollowSign]
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case userID = "userId"
        case posts = "Posts"
        case followings = "Followings"
        case followers = "Followers"
        case image = "Image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        nickname = (try? values.decode(String.self, forKey: .nickname)) ?? ""
        userID = (try? values.decode(String.self, forKey: .userID)) ?? ""
        posts = (try? values.decode([Post].self, forKey: .posts)) ?? []
        followings = (try? values.decode([FollowSign].self, forKey: .followings)) ?? []
        followers = (try? values.decode([FollowSign].self, forKey: .followers)) ?? []
        image = (try? values.decode(String.self, forKey: .image)) ?? ""
    }

}

// MARK: - Follow
struct FollowSign: Codable {
    let id: Int
    let follow: FollowClass

    enum CodingKeys: String, CodingKey {
        case id
        case follow = "Follow"
    }
}

// MARK: - FollowClass
struct FollowClass: Codable {
    let createdAt, updatedAt: String
    let followingID, followerID: Int

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case followingID = "followingId"
        case followerID = "followerId"
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int
}

