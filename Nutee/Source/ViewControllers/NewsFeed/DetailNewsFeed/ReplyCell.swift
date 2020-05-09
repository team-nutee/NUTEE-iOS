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
    
    // NewsFeedVC와 통신하기 위한 델리게이트 변수 선언
    weak var delegate: ReplyCellDelegate?
    weak var RootVC: UIViewController?
    
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
    
    @IBAction func btnCommentMore(_ sender: Any) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let editAction = UIAlertAction(title: "수정", style: .default) {
                (action: UIAlertAction) in
                // Code to EditComment
                self.delegate?.setEditCommentMode(commentId: self.comment?.id ?? 0, commentContent: self.txtvwCommentContents.text)
            }
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
                (action: UIAlertAction) in
                // Code to 수정/삭제 기능
                let deleteAlert = UIAlertController(title: nil, message: "댓글을 삭제 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
                let okAction = UIAlertAction(title: "삭제", style: .destructive) {
                    (action: UIAlertAction) in
                    // Code to delete
                    self.deleteCommentService(postId: self.comment?.postID ?? 0, commentId: self.comment?.id ?? 0, completionHandler: {()-> Void in
                        self.delegate?.updateReplyTV()
                    })
                }
                deleteAlert.addAction(cancelAction)
                deleteAlert.addAction(okAction)
                self.RootVC?.present(deleteAlert, animated: true, completion: nil)
            }
            let reportAction = UIAlertAction(title: "신고하기🚨", style: .destructive) {
                (action: UIAlertAction) in
                // Code to 신고 기능
                let reportAlert = UIAlertController(title: "🚨댓글 신고🚨", message: "", preferredStyle: UIAlertController.Style.alert)
                let cancelAction
                    = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                let reportAction = UIAlertAction(title: "신고", style: .destructive) {
                    (action: UIAlertAction) in
                    let reason = reportAlert.textFields?[0].text ?? "" // 신고 내용
                    self.reportCommentService(reportReason: reason)
                    //신고 여부 알림 <-- 서버연결 코드에서 구현됨
                }
                reportAlert.addTextField { (mytext) in
                    mytext.tintColor = .nuteeGreen
                    mytext.placeholder = "신고할 내용을 입력해주세요."
                }
                reportAlert.addAction(cancelAction)
                reportAlert.addAction(reportAction)
                
                self.RootVC?.present(reportAlert, animated: true, completion: nil)
            }
        
        if comment?.userID == KeychainWrapper.standard.integer(forKey: "id") {
            moreAlert.addAction(editAction)
            moreAlert.addAction(deleteAction)
            moreAlert.addAction(cancelAction)
        } else {
            moreAlert.addAction(reportAction)
            moreAlert.addAction(cancelAction)
        }
        self.RootVC?.present(moreAlert, animated: true, completion: nil)
    }
    
    func initComments() {
        // 사용자 프로필 이미지 설정
        imgCommentUser.setRounded(radius: imgCommentUser.frame.height/2)
        imgCommentUser.setImageNutee(comment?.user.image?.src)
        imgCommentUser.setImageContentMode(comment?.user.image?.src, imgvw: imgCommentUser)
        
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
        
        RootVC?.navigationController?.pushViewController(vc!, animated: true)
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
        
        //Give your image View tag
        if (imgView.tag == 1) {
            showProfile()
        }
    }
}

// MARK: - DetailNewsFeedVC와 통신하기 위한 프로토콜 정의

protocol ReplyCellDelegate: class {
    func updateReplyTV()
    func setEditCommentMode(commentId: Int, commentContent: String)
}

// MARK: - 서버 연결 코드 구간

extension ReplyCell {
    // 뎃글 신고 <-- 확인 필요
    func reportCommentService(reportReason: String) {
        let userid = KeychainWrapper.standard.string(forKey: "id") ?? "" // <-- 수정 必
        ContentService.shared.reportPost(userid, reportReason) { (responsedata) in // <-- 현재 작성된 API는 게시글(post)에 대한 신고기능
            
            switch responsedata {
            case .success(let res):
                
                print(res)
                
                let successfulAlert = UIAlertController(title: "신고가 완료되었습니다", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                successfulAlert.addAction(okAction)
                
                self.RootVC?.present(successfulAlert, animated: true, completion: nil)

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
    
    // 댓글 삭제
    func deleteCommentService(postId: Int, commentId: Int, completionHandler: @escaping () -> Void ) {
        ContentService.shared.commentDelete(postId, commentId: commentId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("commentDelete succussful", res)
                completionHandler()
                
            case .requestErr(_):
                let errorAlert = UIAlertController(title: "오류발생😵", message: "오류가 발생하여 댓글을 삭제하지 못했습니다", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                errorAlert.addAction(okAction)
                
                self.RootVC?.present(errorAlert, animated: true, completion: nil)
                
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
