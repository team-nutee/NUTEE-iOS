//
//  Notice.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import Foundation

// MARK: - Notice
//struct Notice: Codable {
//    let content: [[String]]
//    let hrefs: [[String]]
//}

struct NoticeElement: Codable {
    let no, title: String
    let href: String
    let author: String
    let date: String
}

typealias Notice = [NoticeElement]
