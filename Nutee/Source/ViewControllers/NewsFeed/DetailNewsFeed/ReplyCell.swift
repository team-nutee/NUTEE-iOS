//
//  ReplyCell.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class ReplyCell: UITableViewCell{
    
    //MARK: - UI components
    
    @IBOutlet var contentsCell: UIView!
    
    // 댓글 표시
    @IBOutlet var imgCommentUser: UIImageView!
    @IBOutlet var lblCommentUserId: UIButton!
    @IBOutlet var lblCommentTime: UILabel!
    @IBOutlet var txtvwCommentContents: UITextView!
    @IBOutlet var LeadingToCommentUser: NSLayoutConstraint!
    
    //MARK: - Variables and Properties
    
    weak var newsTV: UITableView?
    weak var detailNewsFeedVC: UIViewController?
    
    var comment: Comment?
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        initComments()
        txtvwCommentContents.font = .systemFont(ofSize: 13)
    }
    
    //MARK: - Helper
    
    @IBAction func showDetailProfile(_ sender: UIButton) {
        showProfile()
    }
    
    func initComments() {
        // 사용자 프로필 이미지 설정
        imgCommentUser.setRounded(radius: imgCommentUser.frame.height/2)
        if comment?.user.image?.src == nil || comment?.user.image?.src == ""{
            imgCommentUser.imageFromUrl((APIConstants.BaseURL) + "/settings/nutee_profile.png", defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
            imgCommentUser.contentMode = .scaleAspectFit
        } else {
            imgCommentUser.imageFromUrl((APIConstants.BaseURL) + "/" + (comment?.user.image?.src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
            imgCommentUser.contentMode = .scaleAspectFill
        }
        
        lblCommentUserId.setTitle(comment?.user.nickname, for: .normal)
        lblCommentUserId.sizeToFit()
        
        
        // 댓글 작성 시간 설정
        if comment?.createdAt == comment?.updatedAt {
            let originPostTime = comment?.createdAt ?? "1970-01-01T00:00:00.000Z" // 기본값 지정 안했을 경우 getDateFormat함수에서 nil값 에러 발생. 시간 임의 지정
            let postTimeDateFormat = originPostTime.getDateFormat(time: originPostTime)
            lblCommentTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
        } else {
            let originPostTime = comment?.updatedAt ?? ""
            let postTimeDateFormat = originPostTime.getDateFormat(time: originPostTime)
            let updatePostTime = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
            lblCommentTime.text = "수정 " + (updatePostTime ?? "")
        }
        
//        let originPostTime = comment?.createdAt
//        let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
//        lblCommentTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
        
        txtvwCommentContents.sizeToFit()
        txtvwCommentContents.text = comment?.content
    }
    
//    func initReComments() {
//        // 대댓글 표현을 위해 오른쪽으로 들여서 댓글 표시
//        LeadingToCommentUser.constant = 45
//
//        imgCommentUser.imageFromUrl((APIConstants.BaseURL) + "/" + (comment?.reComment?..image.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
//        imgCommentUser.contentMode = .scaleAspectFill
//        imgCommentUser.setRounded(radius: imgCommentUser.frame.height/2)
//
//        lblCommentUserId.text = comment?.user.nickname
//        lblCommentUserId.sizeToFit()
//        let originPostTime = comment?.createdAt
//        let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
//        lblCommentTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
//
//        txtvwCommentContents.sizeToFit()
//        txtvwCommentContents.text = comment?.content
//    }
    
    func showProfile() {
        let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        // 선택된 사용자 아이디를 넘거줌
        vc?.userId = comment?.user.id  ?? KeychainWrapper.standard.integer(forKey: "id")
        
        detailNewsFeedVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // 프로필 이미지에 탭 인식하게 만들기
    func setClickActions() {
        imgCommentUser.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        imgCommentUser.isUserInteractionEnabled = true
        imgCommentUser.addGestureRecognizer(tapGestureRecognizer1)
    }
    
    // 프로필 이미지 클릭시 실행 함수
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
        print("your taped image view tag is : \(imgView.tag)")
        
        //Give your image View tag
        if (imgView.tag == 1) {
            showProfile()
        }
    }
}
