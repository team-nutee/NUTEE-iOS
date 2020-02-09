//
//  FollowingTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class FollowingTVC: UITableViewCell {

    @IBOutlet weak var followingImgView: UIImageView!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followingDeleteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followingImgView.setRounded(radius: nil)
        followingImgView.backgroundColor = .veryLightPink
//        followingLabel.sizeToFit()
        followingDeleteBtn.setTitle("삭제", for: .normal)
        followingDeleteBtn.setTitleColor(.nuteeGreen, for: .normal)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
