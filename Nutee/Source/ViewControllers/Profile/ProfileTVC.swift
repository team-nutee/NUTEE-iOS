//
//  ProfileTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewCell {
    
    //MARK: - UI components
    
    // User Information
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imgCntLabel: UILabel!
    @IBOutlet weak var replyCntLabel: UILabel!
    
    // Posting
    @IBOutlet weak var contentLabel: UILabel!
    
    // function buttons2
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var actionBtn: UIButton!
    
    // MARK: - Variables and Properties
    
    var loginUserPost: UserPostContentElement?
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileIMG.setRounded(radius: nil)
        profileIMG.contentMode = .scaleAspectFill
        //        profileIMG.backgroundColor = .lightGray
        likeBtn.tintColor = .lightGray
        likeBtn.titleLabel?.textColor = .lightGray
        actionBtn.tintColor = .lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Helper
    
    //포스팅 내용 설정
    func initLoginUserPost() {
        // User 정보 설정 //
        // 사용자 프로필 이미지 설정
        profileIMG.setRounded(radius: nil)
        if loginUserPost?.user.image?.src == nil || loginUserPost?.user.image?.src == ""{ profileIMG.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
            profileIMG.contentMode = .scaleAspectFit
        } else {
            profileIMG.imageFromUrl((APIConstants.BaseURL) + "/" + (loginUserPost?.user.image?.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
            profileIMG.contentMode = .scaleAspectFill
        }
        // 사용자 이름 설정
        profileNameLabel.text = loginUserPost?.user.nickname
        profileNameLabel.sizeToFit()
        // 게시글 게시 시간 설정
        let originPostTime = loginUserPost?.createdAt
        let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
        timeLabel.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
        
        // Posting 내용 설정
        contentLabel.text = loginUserPost?.content
        
        
    }
}
