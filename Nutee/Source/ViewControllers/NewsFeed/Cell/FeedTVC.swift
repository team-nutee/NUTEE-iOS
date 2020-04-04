//
//  FeedTVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FeedTVC: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNAMELabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var imgCntLabel: UILabel!
    @IBOutlet weak var replyCntLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var actionBtn: UIButton!
    
    //MARK: - Variables and Properties
    
    weak var newsFeedVC: UIViewController?
    var newsPost: NewsPostsContentElement?
    
    var imgCnt: Int?
    
    var numLike: Int?
    var numComment: Int?
    
    var isClickedLike: Bool?
    var isClickedRepost: Bool?
    var isClickedComment: Bool?
    
    // .normal 상태에서의 버튼 AttributedStringTitle의 색깔 지정
    let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    // .selected 상태에서의 Repost버튼 AttributedStringTitle의 색깔 지정
    let selectedRepostAttributes = [NSAttributedString.Key.foregroundColor: UIColor.nuteeGreen]
    // .selected 상태에서의 Like버튼 AttributedStringTitle의 색깔 지정
    let selectedLikeAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        likeBtn.setTitleColor(.veryLightPink, for: .normal)
        likeBtn.setTitleColor(.red, for: .selected)

        likeBtn.setTitleColor(.veryLightPink, for: .normal)
        actionBtn.tintColor = .veryLightPink
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initPosting() {
        userImg.setRounded(radius: nil)
        if newsPost?.user.image?.src == nil || newsPost?.user.image?.src == "" {
            userImg.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
            //            userImg.contentMode = .scaleAspectFit
            userImg.contentMode = .scaleAspectFill
        } else {
            userImg.imageFromUrl((APIConstants.BaseURL) + "/" + (newsPost?.user.image?.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
            userImg.contentMode = .scaleAspectFill
        }
        // 사용자 이름 설정
        //            let nickname = newsPost?.user.nickname ?? ""
        userNAMELabel.text = newsPost?.user.nickname
        userNAMELabel.sizeToFit()
        // 게시글 게시 시간 설정
        if newsPost?.createdAt == newsPost?.updatedAt {
            let originPostTime = newsPost?.createdAt ?? ""
            let postTimeDateFormat = originPostTime.getDateFormat(time: originPostTime)
            dateLabel.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
        } else {
            let originPostTime = newsPost?.updatedAt ?? ""
            let postTimeDateFormat = originPostTime.getDateFormat(time: originPostTime)
            let updatePostTime = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
            dateLabel.text = "✄ " + (updatePostTime ?? "")
        }
        
        // Posting 내용 설정
        contentLabel.text = newsPost?.content
        contentLabel.centerVertically()
        
        imgCnt = newsPost?.images.count
        
        var containLoginUser = false
        // Repost 버튼
        isClickedRepost = false
        if containLoginUser {
            // 로그인 한 사용자가 좋아요를 누른 상태일 경우
            likeBtn.isSelected = true
            numLike = newsPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .selected)
            likeBtn.tintColor = .systemPink
            isClickedLike = true
        } else {
            // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
            likeBtn.isSelected = false
            numLike = newsPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .normal)
            likeBtn.tintColor = .gray
            isClickedLike = false
        }
        // Like 버튼
        containLoginUser = false
        for arrSearch in newsPost?.likers ?? [] {
            if arrSearch.like.userID == KeychainWrapper.standard.integer(forKey: "id") {
                containLoginUser = true
            }
        }
        if containLoginUser {
            // 로그인 한 사용자가 좋아요를 누른 상태일 경우
            likeBtn.isSelected = true
            numLike = newsPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .selected)
            likeBtn.tintColor = .systemPink
            isClickedLike = true
        } else {
            // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
            likeBtn.isSelected = false
            numLike = newsPost?.likers.count ?? 0
            likeBtn.setTitle(" " + String(numLike!), for: .normal)
            likeBtn.tintColor = .gray
            isClickedLike = false
        }
        // Comment 버튼
        replyCntLabel.text = String(newsPost?.comments.count ?? 0)
        imgCntLabel.text = String(newsPost?.images.count ?? 0)
        
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        //        btnLike.isSelected = !btnLike.isSelected
        if isClickedLike! {
            setNormalLikeBtn()
            likeDeleteService(postId: newsPost?.id ?? 0)
        } else {
            setSelectedLikeBtn()
            likePostService(postId: newsPost?.id ?? 0)
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
    
    
    @IBAction func showDetailProfile(_ sender: UIButton) {
        showProfile()
    }
    
    //    @IBAction func btnRepost(_ sender: UIButton) {
    //        // .selected State를 활성화 하기 위한 코드
    //        btnRepost.isSelected = !btnRepost.isSelected
    //        if isClickedRepost! {
    //            isClickedRepost = false
    //            btnRepost.tintColor = .gray
    //            retweetDeleteService(postId: newsPost?.id ?? 0)
    //        } else {
    //            isClickedRepost = true
    //            btnRepost.tintColor = .nuteeGreen
    //            retweetPostService(postId: newsPost?.id ?? 0)
    //        }
    //    }
    
    
    // 프로필 이미지에 탭 인식하게 만들기
    func setClickActions() {
        userImg.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        userImg.isUserInteractionEnabled = true
        userImg.addGestureRecognizer(tapGestureRecognizer1)
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
    
    @IBAction func btnMore(sender: AnyObject) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let editAction = UIAlertAction(title: "수정", style: .default){
            (action: UIAlertAction) in
            // Code to edit
            // Posting 창으로 전환
            let postSB = UIStoryboard(name: "Post", bundle: nil)
            let editPostingVC = postSB.instantiateViewController(withIdentifier: "PostVC") as! PostVC
            
            editPostingVC.loadViewIfNeeded()
            
            editPostingVC.isEditMode = true
            editPostingVC.postingTextView.text = self.newsPost?.content
            editPostingVC.postId = self.newsPost?.id
            editPostingVC.postBtn.setTitle("수정", for: .normal)
            
            editPostingVC.modalPresentationStyle = .currentContext
            self.newsFeedVC?.present(editPostingVC, animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
            (action: UIAlertAction) in
            let deleteAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "확인", style: .default) {
                (action: UIAlertAction) in
                // Code to delete
            }
            deleteAlert.addAction(cancelAction)
            deleteAlert.addAction(okAction)
            self.newsFeedVC?.present(deleteAlert, animated: true, completion: nil)
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
            
            self.newsFeedVC?.present(reportAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let userId = KeychainWrapper.standard.integer(forKey: "id")
        
        if (userId == newsPost?.userID) {
            moreAlert.addAction(editAction)
            moreAlert.addAction(deleteAction)
            moreAlert.addAction(cancelAction)
        } else {
            moreAlert.addAction(userReportAction)
            moreAlert.addAction(cancelAction)
        }
        
        newsFeedVC?.present(moreAlert, animated: true, completion: nil)
    }
    
    
    func showDetailNewsFeed() {
        // DetailNewsFeed 창으로 전환
        let detailNewsFeedSB = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let showDetailNewsFeedVC = detailNewsFeedSB.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC
        
        // 현재 게시물 id를 DetailNewsFeedVC로 넘겨줌
        showDetailNewsFeedVC.postId = self.newsPost?.id
        showDetailNewsFeedVC.getPostService(postId: showDetailNewsFeedVC.postId!, completionHandler: {(returnedData)-> Void in
            showDetailNewsFeedVC.replyTV.reloadData()
        })
        
        newsFeedVC?.navigationController?.pushViewController(showDetailNewsFeedVC, animated: true)
    }
    
    func showProfile() {
        let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        // 해당 글이 공유글인지 아닌지 판단
        if newsPost?.retweet == nil {
            vc?.userId = newsPost?.user.id ?? KeychainWrapper.standard.integer(forKey: "id")
        } else {
            vc?.userId = newsPost?.retweet?.user.id ?? KeychainWrapper.standard.integer(forKey: "id")
        }
        
        newsFeedVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
    
}

extension FeedTVC {
    func reportPost( content: String) {
        let userid = KeychainWrapper.standard.string(forKey: "id") ?? ""
        ContentService.shared.reportPost(userid, content) { (responsedata) in
            
            switch responsedata {
            case .success(_):
                
                let successfulAlert = UIAlertController(title: "신고가 완료되었습니다", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                successfulAlert.addAction(okAction)
                
                self.newsFeedVC?.present(successfulAlert, animated: true, completion: nil)
                
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
}