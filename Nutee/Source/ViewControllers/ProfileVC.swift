//
//  ProfileVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: - UI components
        
    @IBOutlet var imgViewUserImage: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPost: UILabel!
    @IBOutlet var lblPostNum: UILabel!
    @IBOutlet var lblFollowing: UILabel!
    @IBOutlet var lblFollowingNum: UILabel!
    @IBOutlet var lblFollower: UILabel!
    @IBOutlet var lblFollowerNum: UILabel!

    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        imgViewUserImage.image = UIImage(named: "nutee_zigi")
        lblUserId.text = "zigi"
        lblPostNum.text = "123"
        lblFollowingNum.text = "100"
        lblFollowerNum.text = "123"
        setInit()
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {
        imgViewUserImage.setRounded(radius: nil)
    }
    
    func setDefault() {

    }
    



    
}
