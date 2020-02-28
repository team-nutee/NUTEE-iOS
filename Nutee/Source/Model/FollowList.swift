//
//  FollowersList.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/27.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - FollowersList
struct FollowListElement: Codable {
    let id: Int
    let nickname: String
    let follow: FollowFollowers

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case follow = "Follow"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        nickname = (try? values.decode(String.self, forKey: .nickname)) ?? ""
        follow = (try? values.decode(FollowFollowers.self, forKey: .follow)) ??
            FollowFollowers.init(createdAt: "", updatedAt: "", followingID: 0, followerID: 0)
    }
}

// MARK: - Follow
struct FollowFollowers: Codable {
    let createdAt, updatedAt: String
    let followingID, followerID: Int

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case followingID = "followingId"
        case followerID = "followerId"
    }
}

typealias FollowersList = [FollowListElement]
