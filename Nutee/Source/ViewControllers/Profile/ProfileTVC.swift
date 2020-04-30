//
//  ProfileTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

protocol ProfileTVCDelegate: class {
    func updateProfileTV() // NewsFeedVC에 정의되어 있는 프로토콜 함수
}

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
    
    var loginUserPost: NewsPostsContentElement?
    
    weak var ProfileVC: UIViewController?
    
    weak var delegate: ProfileTVCDelegate?

    
    var numLike: Int?
    var numComment: Int?

    
    var isClickedLike: Bool?
    var isClickedRepost: Bool?
    var isClickedComment: Bool?

    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileIMG.setRounded(radius: nil)
        profileIMG.contentMode = .scaleAspectFill
        
        likeBtn.tintColor = .lightGray
        likeBtn.titleLabel?.textColor = .lightGray
        actionBtn.tintColor = .lightGray
        
        likeBtn.setTitleColor(.veryLightPink, for: .normal)
        likeBtn.setTitleColor(.red, for: .selected)

        likeBtn.setTitleColor(.veryLightPink, for: .normal)
        actionBtn.tintColor = .veryLightPink

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
                
        profileIMG.setImageNutee(loginUserPost?.user.image?.src ?? "")
        profileIMG.contentMode = .scaleAspectFill
        
        // 사용자 이름 설정
        profileNameLabel.text = loginUserPost?.user.nickname
        profileNameLabel.sizeToFit()
        // 게시글 게시 시간 설정
        let originPostTime = loginUserPost?.createdAt
        let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
        timeLabel.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
        
        // Posting 내용 설정
        contentLabel.text = loginUserPost?.content
        imgCntLabel.text = String(loginUserPost?.images.count ?? 0)
        replyCntLabel.text = String(loginUserPost?.comments.count ?? 0)
        
//        var containLoginUser = false
//        // Repost 버튼
//        isClickedRepost = false
//        if containLoginUser {
//            // 로그인 한 사용자가 좋아요를 누른 상태일 경우
//            likeBtn.isSelected = true
//            numLike = loginUserPost?.likers.count
//            likeBtn.setTitle(" " + String(numLike!), for: .selected)
//            likeBtn.tintColor = .systemPink
//            isClickedLike = true
//        } else {
            // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
            likeBtn.isSelected = false
            numLike = loginUserPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .normal)
            likeBtn.tintColor = .gray
            isClickedLike = false
//        }
        // Like 버튼
        var containLoginUser = false
        for arrSearch in loginUserPost?.likers ?? [] {
            if arrSearch.like.userID == KeychainWrapper.standard.integer(forKey: "id") {
                containLoginUser = true
            }
        }
        if containLoginUser {
            // 로그인 한 사용자가 좋아요를 누른 상태일 경우
            likeBtn.isSelected = true
            numLike = loginUserPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .selected)
            likeBtn.tintColor = .systemPink
            isClickedLike = true
        } else {
            // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
            likeBtn.isSelected = false
            numLike = loginUserPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .normal)
            likeBtn.tintColor = .gray
            isClickedLike = false
        }

        
    }
    
    
    func setNormalLikeBtn() {
        likeBtn.isSelected = false
        numLike! -= 1
        likeBtn.setTitle(" " + String(numLike!), for: .normal)
        likeBtn.tintColor = .gray
        isClickedLike = false
    }
    
    func setSelectedLikeBtn() {
        likeBtn.isSelected = true
        numLike! += 1
        likeBtn.setTitle(" " + String(numLike!), for: .selected)
        likeBtn.tintColor = .systemPink
        isClickedLike = true
    }
    
    

    
    // MARK: - IBAction
    
    @IBAction func tapLikeBtn(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        //        btnLike.isSelected = !btnLike.isSelected
        if isClickedLike! {
            setNormalLikeBtn()
            likeDeleteService(postId: loginUserPost?.id ?? 0)
        } else {
            setSelectedLikeBtn()
            likePostService(postId: loginUserPost?.id ?? 0)
        }
    }

    @IBAction func tapActionBtn(sender: AnyObject) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let editAction = UIAlertAction(title: "수정", style: .default){
            (action: UIAlertAction) in
            // Code to edit
            // Posting 창으로 전환
            let postSB = UIStoryboard(name: "Post", bundle: nil)
            let editPostingVC = postSB.instantiateViewController(withIdentifier: "PostVC") as! PostVC
            
            editPostingVC.loadViewIfNeeded()
            editPostingVC.editNewsPost = self.loginUserPost
            editPostingVC.setEditMode()
            
            editPostingVC.modalPresentationStyle = .fullScreen
            self.ProfileVC?.present(editPostingVC, animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
            (action: UIAlertAction) in
            let deleteAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "확인", style: .default) {
                (action: UIAlertAction) in
                // Code to 삭제
                self.postDeleteService(postId: self.loginUserPost?.id ?? 0, completionHandler: {() -> Void in
                    // delegate로 NewsFeedVC와 통신하기
                    self.delegate?.updateProfileTV()
                })
            }
            deleteAlert.addAction(cancelAction)
            deleteAlert.addAction(okAction)
            self.ProfileVC?.present(deleteAlert, animated: true, completion: nil)
        }
        let userReportAction = UIAlertAction(title: "신고하기🚨", style: .destructive) {
            (action: UIAlertAction) in
            // Code to 신고 기능
            let reportAlert = UIAlertController(title: "이 게시글을 신고하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
            let cancelAction
                = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let reportAction = UIAlertAction(title: "신고", style: .destructive) {
                (action: UIAlertAction) in
                let content = reportAlert.textFields?[0].text ?? "" // 신고 내용
                self.reportPost(content: content)
                //신고 여부 알림 <-- 서버연결 코드에서 구현됨
            }
            reportAlert.addTextField { (mytext) in
                mytext.tintColor = .nuteeGreen
                mytext.placeholder = "신고할 내용을 입력해주세요."
            }
            reportAlert.addAction(cancelAction)
            reportAlert.addAction(reportAction)
            
            self.ProfileVC?.present(reportAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let userId = KeychainWrapper.standard.integer(forKey: "id")
        
        if (userId == loginUserPost?.userID) {
            moreAlert.addAction(editAction)
            moreAlert.addAction(deleteAction)
            moreAlert.addAction(cancelAction)
        } else {
            moreAlert.addAction(userReportAction)
            moreAlert.addAction(cancelAction)
        }
        
        ProfileVC?.present(moreAlert, animated: true, completion: nil)
    }

    
}

extension ProfileTVC {
    func reportPost( content: String) {
        let userid = KeychainWrapper.standard.string(forKey: "id") ?? ""
        ContentService.shared.reportPost(userid, content) { (responsedata) in
            
            switch responsedata {
            case .success(_):
                
                let successfulAlert = UIAlertController(title: "신고가 완료되었습니다", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                successfulAlert.addAction(okAction)
                
                self.ProfileVC?.present(successfulAlert, animated: true, completion: nil)
                
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
    
    // MARK: - like
    
    func likePostService(postId: Int) {
        ContentService.shared.likePost(postId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("likePost succussful", res)
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
    
    func likeDeleteService(postId: Int) {
        ContentService.shared.likeDelete(postId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("likePost succussful", res)
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
    
    
    // MARK: - Post
    func postDeleteService(postId: Int, completionHandler: @escaping () -> Void ) {
        ContentService.shared.postDelete(postId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("postPost succussful", res)
                completionHandler()
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
