//
//  ProfileVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // <--- 로그인 사용자 정보 받아오기 from 서버
    var dataset = [
        ("nutee_zigi", "뀨?", "1", "1", "2")
    ]
    
    override func viewDidLoad() {
        for(userImg, userId, post, following, follower) in self.dataset {
            imgViewUserImage.image = UIImage(named: userImg)
            lblUserId.text = userId
            lblPostNum.text = post
            lblFollowingNum.text = following
            lblFollowerNum.text = follower
        }
    }
    
    @IBOutlet var imgViewUserImage: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    
    @IBOutlet var lblPost: UILabel!
    @IBOutlet var lblPostNum: UILabel!
    @IBOutlet var lblFollowing: UILabel!
    @IBOutlet var lblFollowingNum: UILabel!
    @IBOutlet var lblFollower: UILabel!
    @IBOutlet var lblFollowerNum: UILabel!
    
}
