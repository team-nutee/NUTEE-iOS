//
//  UITabar.swift
//  Nutee
//
//  Created by Junhyeon on 2020/03/19.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().layer.borderWidth = 0.0

    }
}
