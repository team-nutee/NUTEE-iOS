//
//  ProflieTableViewCell.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ProflieTableViewCell: UITableViewCell {

    //MARK: - UI components
    
    // Repost Info Section
    @IBOutlet var repostPic: UIButton!
    @IBOutlet var lblRepostInfo: UILabel!
    @IBOutlet var TopToRepostImg: NSLayoutConstraint!
    
    // User Information
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet var TopToUserImg: NSLayoutConstraint!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // Posting
    @IBOutlet weak var articleTextView: UITextView!
    
    // function buttons2
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
   
    // MARK: - Variables and Properties
    
    var loginUserPost: UserPostContentElement?
    
    //MARK: - Life Cycle
    
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
    
    //MARK: - Helper
    
    //포스팅 내용 설정
        func initLoginUserPost() {
            print(loginUserPost?.retweet)
            if loginUserPost?.retweetID == nil {
                // <-----공유한 글이 아닐 경우-----> //
                TopToUserImg.isActive = true
                TopToRepostImg.isActive = false
                lblRepostInfo.isHidden = true
                repostPic.isHidden = true

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
                articleTextView.text = loginUserPost?.content
                articleTextView.postingInit()

//                var containLoginUser = false
//                // Repost 버튼
//                isClickedRepost = false
//                btnRepost.tintColor = .gray
//                if containLoginUser {
//                    // 로그인 한 사용자가 좋아요를 누른 상태일 경우
//                    btnLike.isSelected = true
//                    numLike = newsPost?.likers.count ?? 0
//                    btnLike.setTitle(" " + String(numLike!), for: .selected)
//                    btnLike.tintColor = .systemPink
//                    isClickedLike = true
//                } else {
//                    // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
//                    btnLike.isSelected = false
//                    numLike = newsPost?.likers.count ?? 0
//                    btnLike.setTitle(" " + String(numLike!), for: .normal)
//                    btnLike.tintColor = .gray
//                    isClickedLike = false
//                }
//                // Like 버튼
//                containLoginUser = false
//                for arrSearch in newsPost?.likers ?? [] {
//                    if arrSearch.like.userID == UserDefaults.standard.integer(forKey: "id") {
//                        containLoginUser = true
//                    }
//                }
//                if containLoginUser {
//                    // 로그인 한 사용자가 좋아요를 누른 상태일 경우
//                    btnLike.isSelected = true
//                    numLike = newsPost?.likers.count ?? 0
//                    btnLike.setTitle(" " + String(numLike!), for: .selected)
//                    btnLike.tintColor = .systemPink
//                    isClickedLike = true
//                } else {
//                    // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
//                    btnLike.isSelected = false
//                    numLike = newsPost?.likers.count ?? 0
//                    btnLike.setTitle(" " + String(numLike!), for: .normal)
//                    btnLike.tintColor = .gray
//                    isClickedLike = false
//                }
//                // Comment 버튼
//                numComment = newsPost?.comments.count ?? 0
//                setButtonPlain(btn: btnComment, num: numComment!, color: .gray, state: .normal)
            } else {
                // <-----공유한 글 일 경우-----> //
                TopToUserImg.isActive = false
                TopToRepostImg.isActive = true
                lblRepostInfo.isHidden = false
                repostPic.isHidden = false
                lblRepostInfo.text = "내가 공유했습니다"
                lblRepostInfo.sizeToFit()
                // User 정보 설정 //
                // 사용자 프로필 이미지 설정
                profileIMG.setRounded(radius: nil)
                if loginUserPost?.retweet?.user.image?.src == nil || loginUserPost?.retweet?.user.image?.src == "" {
                    profileIMG.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                    profileIMG.contentMode = .scaleAspectFit
                } else {
                    profileIMG.imageFromUrl((APIConstants.BaseURL) + "/" + (loginUserPost?.retweet?.user.image?.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                    profileIMG.contentMode = .scaleAspectFill
                }
                // 사용자 이름 설정
                profileNameLabel.text = loginUserPost?.retweet?.user.nickname
                profileNameLabel.sizeToFit()
                // 게시글 게시 시간 설정
                let originPostTime = loginUserPost?.retweet?.createdAt
                let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
                profileNameLabel.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)

                // Posting 내용 설정
                articleTextView.text = loginUserPost?.retweet?.content
                articleTextView.postingInit()

                // Like 버튼
//                var containLoginUser = false
//                for arrSearch in newsPost?.retweet?.likers ?? [] {
//                    if arrSearch.like.userID == UserDefaults.standard.integer(forKey: "id") {
//                        containLoginUser = true
//                    }
//                }
//                if containLoginUser {
//                    // 로그인 한 사용자가 좋아요를 누른 상태일 경우
//                    btnLike.isSelected = true
//                    numLike = newsPost?.retweet?.likers.count ?? 0
//                    btnLike.setTitle(" " + String(numLike!), for: .selected)
//                    btnLike.tintColor = .systemPink
//                    isClickedLike = true
//                } else {
//                    // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
//                    btnLike.isSelected = false
//                    numLike = newsPost?.retweet?.likers.count ?? 0
//                    btnLike.setTitle(" " + String(numLike!), for: .normal)
//                    btnLike.tintColor = .gray
//                    isClickedLike = false
//                }

    //            // Repost 버튼
    //            isClickedRepost = false
    //            btnRepost.isSelected = false
    //            btnRepost.tintColor = .gray
    //            btnRepost.isEnabled = false
    //            // Like 버튼
    //            isClickedLike = false
    //            numLike = nil
    //            btnLike.setTitle(String(""), for: .normal)
    //            btnLike.isEnabled = false

                // Comment 버튼
//                numComment = newsPost?.retweet?.comments.count ?? 0
//                setButtonPlain(btn: btnComment, num: numComment!, color: .gray, state: .normal)
            }
            
        }
}
