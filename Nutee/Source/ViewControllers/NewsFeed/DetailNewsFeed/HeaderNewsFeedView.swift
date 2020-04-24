//
//  NewsFeedTableHeaderSection.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper

class HeaderNewsFeedView: UITableViewHeaderFooterView {
    
    //MARK: - UI components
    
    // Repost Info Section
    @IBOutlet var repostPic: UIButton!
    @IBOutlet var lblRepostInfo: UILabel!
    @IBOutlet var TopToRepostImg: NSLayoutConstraint!
    
    // User Information
    @IBOutlet var imgvwUserImg: UIImageView!
    @IBOutlet var TopToUserImg: NSLayoutConstraint!
    @IBOutlet var lblUserId: UIButton!
    @IBOutlet var lblPostTime: UILabel!
    
    // Posting
    @IBOutlet var txtvwContent: UITextView!
    @IBOutlet var ContentsToRepost: NSLayoutConstraint!
    
    // ver. TwoFrame
    @IBOutlet var vwTwo: UIView!
    @IBOutlet var imgvwTwo: [UIImageView]!
    @IBOutlet var lblTwoMoreImg: UILabel!
    @IBOutlet var vwTwoToRepost: NSLayoutConstraint!
    
    //앨범 프레임 three, four 버전을 통합관리 할 view 객체 생성
    @IBOutlet var vwSquare: UIView!
    @IBOutlet var vwSquareToRepost: NSLayoutConstraint!
    // ver. OneImage(without frame)
    @IBOutlet var imgvwOne: UIImageView!
    // ver. ThreeFrame
    @IBOutlet var vwThree: UIView!
    @IBOutlet var imgvwThree: [UIImageView]!
    @IBOutlet var lblThreeMoreImg: UILabel!
    // ver. FourFrame
    @IBOutlet var vwFour: UIView!
    @IBOutlet var imgvwFour: [UIImageView]!
    @IBOutlet var lblFourMoreImg: UILabel!
    
    // function buttons
    @IBOutlet var btnRepost: UIButton!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnComment: UIButton!
    @IBOutlet var btnMore: UIButton!
    
    //MARK: - Variables and Properties
    
    // NewsFeedVC와 통신하기 위한 델리게이트 변수 선언
    weak var delegate: HeaderNewsFeedViewDelegate?
    weak var detailNewsFeedVC: UIViewController?
    
    var detailNewsPost: NewsPostsContentElement?
    
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
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        btnRepost.isEnabled = true
        btnLike.isEnabled = true
        btnMore.isEnabled = true
    }
    
    //MARK: - Helper
    
    @IBAction func showDetailProfile(_ sender: UIButton) {
        showProfile()
    }
    
    @IBAction func btnRepost(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnRepost.isSelected = !btnRepost.isSelected
        if isClickedRepost! {
            isClickedRepost = false
            btnRepost.tintColor = .gray
            retweetDeleteService(postId: detailNewsPost?.id ?? 0)
        } else {
            isClickedRepost = true
            btnRepost.tintColor = .nuteeGreen
            retweetPostService(postId: detailNewsPost?.id ?? 0)
        }
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
            self.detailNewsFeedVC?.present(editPostingVC, animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
            (action: UIAlertAction) in
            let deleteAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "확인", style: .default) {
                (action: UIAlertAction) in
                // Code to 삭제
//                self.delegate?.deletePostAndBackToMainNewsTV(completionHandler: {returnedData -> Void in
//                    self.detailNewsFeedVC?.navigationController?.popViewController(animated: true)
//                }) // MianNewsfeed에 있는 FeedTVC의 삭제 기능을 통해 글 삭제
            }
            deleteAlert.addAction(cancelAction)
            deleteAlert.addAction(okAction)
            self.detailNewsFeedVC?.present(deleteAlert, animated: true, completion: nil)
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
            
            self.detailNewsFeedVC?.present(reportAlert, animated: true, completion: nil)
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
        
        detailNewsFeedVC?.present(moreAlert, animated: true, completion: nil)
    }
    
    func initPosting() {
        if detailNewsPost?.retweetID == nil {
            // <-----공유한 글이 아닐 경우-----> //
            repostPic.isHidden = true
            
            TopToUserImg.isActive = true
            TopToRepostImg.isActive = false
            lblRepostInfo.isHidden = true
            
            // User 정보 설정 //
            // 사용자 프로필 이미지 설정
            imgvwUserImg.setRounded(radius: nil)
            imgvwUserImg.setImageNutee(detailNewsPost?.user.image?.src)
            imgvwUserImg.contentMode = .scaleAspectFill
            
            // 사용자 이름 설정
            //            let nickname = newsPost?.user.nickname ?? ""
            lblUserId.setTitle(detailNewsPost?.user.nickname, for: .normal)
            lblUserId.sizeToFit()
            // 게시글 게시 시간 설정
            let originPostTime = detailNewsPost?.createdAt
            let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
            lblPostTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
            
            // Posting 내용 설정
            txtvwContent.text = detailNewsPost?.content
            txtvwContent.postingInit()
            
            imgCnt = detailNewsPost?.images.count
            showImgFrame()
            
            var containLoginUser = false
            // Repost 버튼
            isClickedRepost = false
            btnRepost.tintColor = .gray
            if containLoginUser {
                // 로그인 한 사용자가 좋아요를 누른 상태일 경우
                btnLike.isSelected = true
                numLike = detailNewsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .selected)
                btnLike.tintColor = .systemPink
                isClickedLike = true
            } else {
                // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
                btnLike.isSelected = false
                numLike = detailNewsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .normal)
                btnLike.tintColor = .gray
                isClickedLike = false
            }
            // Like 버튼
            containLoginUser = false
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
                isClickedLike = true
            } else {
                // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
                btnLike.isSelected = false
                numLike = detailNewsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .normal)
                btnLike.tintColor = .gray
                isClickedLike = false
            }
            // Comment 버튼
            numComment = detailNewsPost?.comments.count ?? 0
            setButtonPlain(btn: btnComment, num: numComment!, color: .gray, state: .normal)
        } else {
            // <-----공유한 글 일 경우-----> //
            repostPic.isHidden = false
            
            TopToUserImg.isActive = false
            TopToRepostImg.isActive = true
            lblRepostInfo.isHidden = false
            lblRepostInfo.text = (detailNewsPost?.user.nickname)! + " 님이 공유했습니다"
            
            // User 정보 설정 //
            // 사용자 프로필 이미지 설정
            imgvwUserImg.setRounded(radius: nil)
            imgvwUserImg.setImageNutee(detailNewsPost?.retweet?.user.image?.src)
            imgvwUserImg.contentMode = .scaleAspectFill
            
            // 사용자 이름 설정
            let nickname = detailNewsPost?.retweet?.user.nickname ?? ""
            lblUserId.setTitle(detailNewsPost?.retweet?.user.nickname, for: .normal)
            lblUserId.sizeToFit()
            // 게시글 게시 시간 설정
            let originPostTime = detailNewsPost?.retweet?.createdAt
            let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
            lblPostTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
            
            // Posting 내용 설정
            txtvwContent.text = detailNewsPost?.retweet?.content
            txtvwContent.postingInit()
            
            imgCnt = detailNewsPost?.retweet?.images.count
            showImgFrame()
            
            // Like 버튼
            var containLoginUser = false
            for arrSearch in detailNewsPost?.retweet?.likers ?? [] {
                if arrSearch.like.userID == KeychainWrapper.standard.integer(forKey: "id") {
                    containLoginUser = true
                }
            }
            if containLoginUser {
                // 로그인 한 사용자가 좋아요를 누른 상태일 경우
                btnLike.isSelected = true
                numLike = detailNewsPost?.retweet?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .selected)
                btnLike.tintColor = .systemPink
                isClickedLike = true
            } else {
                // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
                btnLike.isSelected = false
                numLike = detailNewsPost?.retweet?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .normal)
                btnLike.tintColor = .gray
                isClickedLike = false
            }
            
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
            numComment = detailNewsPost?.retweet?.comments.count ?? 0
            setButtonPlain(btn: btnComment, num: numComment!, color: .gray, state: .normal)
        }
    }
    
    func setNormalLikeBtn() {
        btnLike.isSelected = false
        numLike! -= 1
        btnLike.setTitle(" " + String(numLike!), for: .normal)
        btnLike.tintColor = .gray
        isClickedLike = false
    }
    
    func setSelectedLikeBtn() {
        btnLike.isSelected = true
        numLike! += 1
        btnLike.setTitle(" " + String(numLike!), for: .selected)
        btnLike.tintColor = .systemPink
        isClickedLike = true
    }
    
    func setButtonPlain(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        btn.setTitle(" " + String(num), for: state)
        btn.setTitleColor(color, for: state)
        btn.tintColor = color
    }
    
    // 사진 개수에 따른 이미지 표시 유형 선택
    func showImgFrame() {
        //constrain layout 충돌 방지를 위한 이미지 뷰 전체 hidden 설정
        vwTwo.isHidden = true
        vwSquare.isHidden = true
        
        var num = 0
        
        var isRepost = false
        if detailNewsPost?.retweet == nil {
            isRepost = false
        } else {
            isRepost = true
        }
        var imageCnt = 0
        if isRepost {
            imageCnt = detailNewsPost?.retweet?.images.count ?? 0
        } else {
            imageCnt = detailNewsPost?.images.count ?? 0
        }
        switch imageCnt {
        case 0:
            // 보여줄 사진이 없는 경우(글만 표시)
            lblTwoMoreImg.isHidden = true
            lblThreeMoreImg.isHidden = true
            lblFourMoreImg.isHidden = true
            
            //            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            //            ContentToVwSquare.isActive = false
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = true
            
        case 1:
            // ver. only OneImage
            vwSquare.isHidden = false
            
            imgvwOne.isHidden = false
            vwThree.isHidden = true
            vwFour.isHidden = true
            
            //            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            //            ContentToVwSquare.isActive = true
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            if isRepost {
                imgvwOne.setImageNutee(detailNewsPost?.retweet?.images[0].src)
            } else {
                imgvwOne.setImageNutee(detailNewsPost?.images[0].src)
            }
            
        case 2:
            // ver. TwoFrame
            vwTwo.isHidden = false
            
            //            ContentToVwTwo.isActive = true
            vwTwoToRepost.isActive = true
            //            ContentToVwSquare.isActive = false
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwTwo {
                if isRepost {
//                    imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.retweet?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                    imgvw.setImageNutee(detailNewsPost?.retweet?.images[num].src)
                } else {
//                    imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                    imgvw.setImageNutee(detailNewsPost?.images[num].src)
                }
                if num == 1 {
                    let leftImg = imageCnt - 2
                    imgvw.alpha = 1.0
                    if leftImg > 0 {
                        imgvw.alpha = 0.5
                        lblTwoMoreImg.isHidden = false
                        lblTwoMoreImg.text = String(leftImg) + " +"
                        lblTwoMoreImg.sizeToFit()
                    } else {
                        lblTwoMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        case 3:
            // ver. ThreeFrame
            vwSquare.isHidden = false
            
            imgvwOne.isHidden = true
            vwFour.isHidden = true
            
            //            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            //            ContentToVwSquare.isActive = true
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwThree {
                if isRepost {
//                    imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.retweet?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                    imgvw.setImageNutee(detailNewsPost?.retweet?.images[num].src)
                } else {
//                    imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                    imgvw.setImageNutee(detailNewsPost?.images[num].src)
                }
                if num == 2 {
                    let leftImg = imageCnt - 3
                    imgvw.alpha = 1.0
                    if leftImg > 0 {
                        imgvw.alpha = 0.5
                        lblThreeMoreImg.isHidden = false
                        lblThreeMoreImg.text = String(leftImg) + " +"
                        lblThreeMoreImg.sizeToFit()
                    } else {
                        lblThreeMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        default:
            // ver. FourFrame
            vwSquare.isHidden = false
            
            imgvwOne.isHidden = true
            vwThree.isHidden = true
            
            //            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            //            ContentToVwSquare.isActive = true
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwFour {
                if num <= 3 {
                    if isRepost {
//                        imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.retweet?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                        imgvw.setImageNutee(detailNewsPost?.retweet?.images[num].src)
                    } else {
//                        imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                        imgvw.setImageNutee(detailNewsPost?.images[num].src)
                    }
                }
                if num == 3 {
                    let leftImg = imageCnt - 4
                    imgvw.alpha = 1.0
                    if leftImg > 0 {
                        imgvw.alpha = 0.5
                        lblFourMoreImg.isHidden = false
                        lblFourMoreImg.text = String(leftImg) + " +"
                        lblFourMoreImg.sizeToFit()
                    } else {
                        lblFourMoreImg.isHidden = true
                    }
                }
                num += 1
            }
            
        } // case문 종료
    } // ShowImageFrame 설정 끝
    
    // 프로필 이미지에 탭 인식하게 만들기
    func setClickActions() {
        imgvwUserImg.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        imgvwUserImg.isUserInteractionEnabled = true
        imgvwUserImg.addGestureRecognizer(tapGestureRecognizer1)
    }
    
    // 프로필 이미지 클릭시 실행 함수
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
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
        
        detailNewsFeedVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
}

// MARK: - DetailNewsFeedVC와 통신하기 위한 프로토콜 정의

protocol HeaderNewsFeedViewDelegate: class {
    func deletePostAndBackToMainNewsTV(completionHandler: @escaping () -> Void) // FeedTVC에 정의되어 있는 프로토콜 함수
}

// MARK: - 서버 연결 코드 구간

extension HeaderNewsFeedView {
    
    func reportPost( content: String) {
        let userid = KeychainWrapper.standard.string(forKey: "id") ?? ""
        ContentService.shared.reportPost(userid, content) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                let successfulAlert = UIAlertController(title: "신고가 완료되었습니다", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                successfulAlert.addAction(okAction)
                
                self.detailNewsFeedVC?.present(successfulAlert, animated: true, completion: nil)
                
                
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
    
    // MARK: - Retweet
    
    func retweetPostService(postId: Int) {
        ContentService.shared.retweetPost(postId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("retweetPost succussful", res)
            case .requestErr(_):
                print("request error")
                
                self.isClickedRepost = true
                self.btnRepost.tintColor = .nuteeGreen
                
                let alreadyAlert = UIAlertController(title: nil, message: "❣️이미 공유한 글입니다❣️", preferredStyle: UIAlertController.Style.actionSheet)
                let okayAction = UIAlertAction(title: "확인", style: .default)
                alreadyAlert.addAction(okayAction)
                self.detailNewsFeedVC?.present(alreadyAlert, animated: true, completion: nil)
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail :
                print("failure")
            }
        }
    }
    
    func retweetDeleteService(postId: Int) {
        ContentService.shared.retweetDelete(postId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("retweetPost succussful", res)
            case .requestErr(_):
                print("request error")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
                let failAlert = UIAlertController(title: nil, message: "이미 공유한 글은\n취소 할 수 없습니다😵", preferredStyle: UIAlertController.Style.alert)
                let okayAction = UIAlertAction(title: "확인", style: .default)
                failAlert.addAction(okayAction)
                self.detailNewsFeedVC?.present(failAlert, animated: true, completion: nil)
                
                self.isClickedRepost = true
                self.btnRepost.tintColor = .nuteeGreen
                
            case .networkFail :
                print("failure")
            }
        }
    }
    
}

