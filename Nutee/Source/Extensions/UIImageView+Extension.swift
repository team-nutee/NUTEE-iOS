//
//  UIImageView+Extension.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/24.
//  Copyright © 2020 S.OWL. All rights reserved.


import Foundation
import Kingfisher
import UIKit

// Kingfisher를 이용하여 url로부터 이미지를 가져오는 extension
extension UIImageView {
    
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String?) {
//        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString, let defaultURL : String = defaultImgPath {
            if url.isEmpty {
//                self.image = defaultImg
                self.kf.setImage(with: URL(string: defaultURL), options: [.transition(ImageTransition.fade(0.5))])
            } else {
                self.kf.setImage(with: URL(string: url), options: [.transition(ImageTransition.fade(0.5))])
            }
        }
        
    }
    

    
}
