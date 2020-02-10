//
//  Food.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/10.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

//struct Food : Codable{
    
//}
struct MypageMainInfo : Codable {
    let message: String
    let data: InfoData
}

// MARK: - InfoData
struct InfoData : Codable {
    let userInfo: UserInfo
}

// MARK: - UserInfo
struct UserInfo : Codable {
    let name: String
    let profileImage: String
    let rank, groupName, groupDepartment: String
    let count: Int
}
