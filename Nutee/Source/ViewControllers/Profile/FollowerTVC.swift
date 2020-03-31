//
//  FollowerTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FollowerTVC: UITableViewCell {

    @IBOutlet var contentsCell: UIView!
    @IBOutlet weak var followerImgView: UIImageView!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followerDeleteBtn: UIButton!
    
    
    var followerID : Int?

    override func awakeFromNib() {
        super.awakeFromNib()

        followerImgView.setRounded(radius: nil)
        followerImgView.contentMode = .scaleAspectFill
        
        followerDeleteBtn.setTitle("삭제", for: .normal)
        followerDeleteBtn.setTitleColor(.nuteeGreen, for: .normal)
                
    }

    @IBAction func deleteBtn(_ sender: UIButton){
        deleteFollowerService(id: followerID!)
    }
}

extension FollowerTVC {
        
        @objc func deleteFollowerService(id : Int) {
            FollowService.shared.deleteFollow(id) { responsedata in
                
                switch responsedata {
                    
                case .success(_):
                    print("success")
                    
                case .requestErr(_):
                    print("request error")
                
                case .pathErr:
                    print(".pathErr")
                
                case .serverErr:
                    print(".serverErr")
                
                case .networkFail :
                    print("failure")
                    }
            }
            
        }


}
