//
//  FollowerTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class FollowerTVC: UITableViewCell {

    @IBOutlet weak var followerImgView: UIImageView!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followerDeleteBtn: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followerImgView.setRounded(radius: nil)
        followerImgView.backgroundColor = .veryLightPink
//        followerLabel.sizeToFit()
        followerDeleteBtn.setTitle("삭제", for: .normal)
        followerDeleteBtn.setTitleColor(.nuteeGreen, for: .normal)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}