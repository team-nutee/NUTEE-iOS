//
//  FeedHederView.swift
//  Nutee
//
//  Created by Junhyeon on 2020/04/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class DetailHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - UI components
    
    // User Information
    @IBOutlet var userIMG: UIImageView!
    @IBOutlet var userName: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var btnMore: UIButton!
    
    // Posting
    @IBOutlet weak var contentTextView: UITextView!
    //앨범 이미지 1, 3, 4개수 프레임
    @IBOutlet weak var imageWrapperView: UIView!
    //앨범 이미지 높이
    @IBOutlet var imageWrapperViewHeight: NSLayoutConstraint!
    // Images 개수
    @IBOutlet var oneImageView : UIImageView!
    @IBOutlet var threeImageViewArr: [UIImageView]!
    @IBOutlet var fourImageViewArr : [UIImageView]!
    // 더보기 Label
    @IBOutlet var moreLabel1: UILabel!
    @IBOutlet var moreLabel4: UILabel!
    
    // 좋아요 Button
    @IBOutlet var btnLike: UIButton!
    
    //MARK: - Variables and Properties
    
    weak var RootVC: UIViewController?
    
    var detailNewsPost: NewsPostsContentElement?
    
    var imageCnt: Int?
    
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
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        btnLike.isEnabled = true
        btnMore.isEnabled = true
    }
    
    //MARK: - Helper
    
    @IBAction func showDetailProfile(_ sender: UIButton) {
        showProfile()
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        //        btnLike.isSelected = !btnLike.isSelected
        if isClickedLike! {
            setNormalLikeBtn()
            likeDeleteService(postId: detailNewsPost?.id ?? 0)
        } else {
            setSelectedLikeBtn()
            likePostService(postId: detailNewsPost?.id ?? 0)
        }
    }
    
    @IBAction func btnMore(_ sender: Any) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let editAction = UIAlertAction(title: "수정", style: .default){
            (action: UIAlertAction) in
            // Code to edit
            // Posting 창으로 전환
            let postSB = UIStoryboard(name: "Post", bundle: nil)
            let editPostingVC = postSB.instantiateViewController(withIdentifier: "PostVC") as! PostVC
            
            editPostingVC.loadViewIfNeeded()
            editPostingVC.editNewsPost = self.detailNewsPost
            editPostingVC.setEditMode()
            
            editPostingVC.modalPresentationStyle = .fullScreen
            self.RootVC?.present(editPostingVC, animated: true, completion: nil)
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
            self.RootVC?.present(deleteAlert, animated: true, completion: nil)
        }
        let userReportAction = UIAlertAction(title: "신고하기🚨", style: .destructive) {
            (action: UIAlertAction) in
            // Code to 신고 기능
            let reportAlert = UIAlertController(title: "이 게시글을 신고하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
            let cancelAction
                = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let reportAction = UIAlertAction(title: "신고", style: .destructive) {
                (action: UIAlertAction) in
                // <---- 신고 기능 구현
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
            
            self.RootVC?.present(reportAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let userid = KeychainWrapper.standard.integer(forKey: "id")
        
        if (userid == detailNewsPost?.userID) {
            moreAlert.addAction(editAction)
            moreAlert.addAction(deleteAction)
            moreAlert.addAction(cancelAction)
        } else {
            moreAlert.addAction(userReportAction)
            moreAlert.addAction(cancelAction)
        }
        RootVC?.present(moreAlert, animated: true, completion: nil)
    }
    
    func initPosting() {
        if detailNewsPost?.retweetID == nil {
            // 사용자 프로필 이미지 설정
            userIMG.setRounded(radius: nil)
            if detailNewsPost?.user.image?.src == nil || detailNewsPost?.user.image?.src == ""{
                userIMG.imageFromUrl((APIConstants.BaseURL) + "/settings/nutee_profile.png", defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
                userIMG.contentMode = .scaleAspectFit
            } else {
                userIMG.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.user.image?.src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
                userIMG.contentMode = .scaleAspectFill
            }
            // 사용자 이름 설정
            userName.setTitle(detailNewsPost?.user.nickname, for: .normal)
            userName.sizeToFit()
            // 게시글 게시 시간 설정
            let originPostTime = detailNewsPost?.createdAt
            let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
            dateLabel.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
            
            // Posting 내용 설정
            contentTextView.text = detailNewsPost?.content
            contentTextView.postingInit()
            
            // 게시글 이미지 설정
            imageCnt = detailNewsPost?.images.count
            showImgFrame()
            
            // Like 버튼
            var containLoginUser = false
            for arrSearch in detailNewsPost?.likers ?? [] {
                if arrSearch.like.userID == KeychainWrapper.standard.integer(forKey: "id") {
                    containLoginUser = true
                }
            }
            if containLoginUser {
                // 로그인 한 사용자가 좋아요를 누른 상태일 경우
                btnLike.isSelected = true
                numLike = detailNewsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .selected)
                btnLike.tintColor = .systemPink
                btnLike.setTitleColor(.systemPink, for: .selected)
                isClickedLike = true
            } else {
                // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
                btnLike.isSelected = false
                numLike = detailNewsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .normal)
                btnLike.tintColor = .gray
                btnLike.setTitleColor(.gray, for: .normal)
                isClickedLike = false
            }
        }
    }
    
    func setNormalLikeBtn() {
        btnLike.isSelected = false
        numLike! -= 1
        btnLike.setTitle(" " + String(numLike ?? 0), for: .normal)
        btnLike.tintColor = .gray
        btnLike.setTitleColor(.gray, for: .normal)
        isClickedLike = false
    }
    
    func setSelectedLikeBtn() {
        btnLike.isSelected = true
        numLike! += 1
        btnLike.setTitle(" " + String(numLike ?? 0), for: .selected)
        btnLike.tintColor = .systemPink
        btnLike.setTitleColor(.systemPink, for: .selected)
        isClickedLike = true
    }
    
    func setButtonPlain(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        btn.setTitle(" " + String(num), for: state)
        btn.setTitleColor(color, for: state)
        btn.tintColor = color
    }
    
    // 사진 개수에 따른 이미지 표시 유형 선택
    func showImgFrame() {
        moreLabel1.isHidden = true
        moreLabel4.isHidden = true
        
        var num = 0
        switch imageCnt {
        case 0:
            // 보여줄 사진이 없는 경우(글만 표시)
            imageWrapperViewHeight.constant = 0
        case 1:
            // ver. only OneImage
            oneImageView.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[0].src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
        case 2:
            oneImageView.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[0].src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
            moreLabel1.isHidden = false
            oneImageView.alpha = 0.5
            moreLabel1.text = "+1"
        case 3:
            for imgvw in threeImageViewArr {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
                num += 1
            }
        default:
            // ver. FourFrame
            for imgvw in fourImageViewArr {
                if num <= 3 {
                    imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
                }
                
                if num == 3 {
                    let leftImg = (imageCnt ?? 3) - 4
                    if leftImg > 0 {
                        imgvw.alpha = 0.5
                        moreLabel4.isHidden = false
                        moreLabel4.text = "+" + String(leftImg)
                    }
                }
                num += 1
            }
        } // End of case statement
    } // Finish ShowImageFrame
    
    // 프로필 이미지에 탭 인식하게 만들기
    func setClickActions() {
        userIMG.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        userIMG.isUserInteractionEnabled = true
        userIMG.addGestureRecognizer(tapGestureRecognizer1)
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
    
    func showProfile() {
        let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        // 해당 글이 공유글인지 아닌지 판단
        if detailNewsPost?.retweet == nil {
            vc?.userId = detailNewsPost?.user.id ?? KeychainWrapper.standard.integer(forKey: "id")
        } else {
            vc?.userId = detailNewsPost?.retweet?.user.id ?? KeychainWrapper.standard.integer(forKey: "id")
        }
        
        RootVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
}

// MARK: - 서버 연결 코드 구간

extension DetailHeaderView {
    
    func reportPost( content: String) {
        let userid = KeychainWrapper.standard.string(forKey: "id") ?? ""
        ContentService.shared.reportPost(userid, content) { (responsedata) in
            
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
