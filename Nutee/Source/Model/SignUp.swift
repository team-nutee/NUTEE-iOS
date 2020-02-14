//
//  SignUpModel.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/13.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - SignUp
struct SignUp: Codable {
    let id: Int
    let nickname, userID, password, updatedAt: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case userID = "userId"
        case password, updatedAt, createdAt
    }
}

// 이미 사용중인 아이디입니다.
//
