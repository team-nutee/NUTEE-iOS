//
//  ProflieTableViewCell.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ProflieTableViewCell: UITableViewCell {

    // Repost Info Section
    @IBOutlet var lblRepostInfo: UILabel!
    @IBOutlet var TopToRepostImg: NSLayoutConstraint!
    
    // User Information
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // Posting
    @IBOutlet weak var articleTextView: UITextView!
    
    // function buttons2
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileIMG.setRounded(radius: nil)
        profileIMG.contentMode = .scaleAspectFill
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
