//
//  FollowingTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class FollowingTVC: UITableViewCell {

    @IBOutlet var contentsCell: UIView!
    @IBOutlet weak var followingImgView: UIImageView!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followingDeleteBtn: UIButton!
    
    var followingID : Int?
    var isFollow : Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
        
        followingImgView.setRounded(radius: nil)
        followingImgView.contentMode = .scaleAspectFill

        followingDeleteBtn.setTitle("팔로잉", for: .normal)
        followingDeleteBtn.setTitleColor(.nuteeGreen, for: .normal)
        followingDeleteBtn.sizeToFit()
        
    }
    
    @IBAction func deleteBtn(_ sender: UIButton){
        if isFollow {
            unfollow(id: followingID!)
        } else {
            follow(id: followingID!)
        }
    }

}

extension FollowingTVC {
        
        @objc func unfollow(id: Int) {
            FollowService.shared.unFollow(id) { responsedata in

                switch responsedata {
                case .success(_):
                    self.followingDeleteBtn.setTitle("팔로우", for: .normal)
                    self.isFollow = !self.isFollow
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

    @objc func follow(id: Int) {
        FollowService.shared.follow(id) { responsedata in

            switch responsedata {
            case .success(_):
                self.followingDeleteBtn.setTitle("팔로잉", for: .normal)
                self.isFollow = !self.isFollow

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
