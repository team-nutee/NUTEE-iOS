//
//  ProflieTableViewCell.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ProflieTableViewCell: UITableViewCell {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileIMG.setRounded(radius: nil)
//        profileIMG.backgroundColor = .lightGray
        shareBtn.tintColor = .lightGray
        shareBtn.titleLabel?.textColor = .lightGray
        likeBtn.tintColor = .lightGray
        likeBtn.titleLabel?.textColor = .lightGray
        replyBtn.tintColor = .lightGray
        replyBtn.titleLabel?.textColor = .lightGray
        moreBtn.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
