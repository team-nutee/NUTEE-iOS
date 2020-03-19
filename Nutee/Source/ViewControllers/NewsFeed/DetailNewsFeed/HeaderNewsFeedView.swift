//
//  NewsFeedTableHeaderSection.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class HeaderNewsFeedView: UITableViewHeaderFooterView {
    
    //MARK: - UI components
    
    // Repost Info Section
    @IBOutlet var repostPic: UIButton!
    @IBOutlet var lblRepostInfo: UILabel!
    @IBOutlet var TopToRepostImg: NSLayoutConstraint!
    
    // User Information
    @IBOutlet var imgvwUserImg: UIImageView!
    @IBOutlet var TopToUserImg: NSLayoutConstraint!
    @IBOutlet var lblUserId: UILabel!
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
    
    weak var detailNewsFeedVC: UIViewController?
    
    //    var content: NewsPostsContentElement?
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
    
    @IBAction func showDetailProfile(_ sender: Any) {
        showProfile()
    }
    
    @IBAction func btnRepost(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnRepost.isSelected = !btnRepost.isSelected
        if isClickedRepost! {
            btnRepost.tintColor = .nuteeGreen
            isClickedRepost = false
        } else {
            btnRepost.tintColor = .gray
            isClickedRepost = true
        }
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        //        btnLike.isSelected = !btnLike.isSelected
        if isClickedLike! {
            setNormalLikeBtn()
        } else {
            setSelectedLikeBtn()
        }
    }
    
    @IBAction func btnMore(_ sender: Any) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let editAction = UIAlertAction(title: "수정", style: .default){
            (action: UIAlertAction) in
            // Code to edit
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
                // <---- 신고 기능 구현
                let content = reportAlert.textFields?[0].text ?? "" // 신고 내용
                //                let postId = self.newsPost?.id ?? 0
                self.reportPost(content: content)
                
                
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
        
        let userid = Int(UserDefaults.standard.string(forKey: "id") ?? "")
        
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
        if detailNewsPost?.user.image?.src == nil || detailNewsPost?.user.image?.src == ""{
        imgvwUserImg.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        } else {
        imgvwUserImg.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.user.image?.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        }

        imgvwUserImg.setRounded(radius: nil)
        
        if detailNewsPost?.retweetID == nil {
            // <-----공유한 글이 아닐 경우-----> //
            TopToUserImg.isActive = true
            TopToRepostImg.isActive = false
            repostPic.isHidden = true
            lblRepostInfo.isHidden = true
            
            // User 정보 설정
            lblUserId.text = detailNewsPost?.user.nickname
            lblUserId.sizeToFit()
            let originPostTime = detailNewsPost?.createdAt
            let postTimeDateFormat = originPostTime?.getDateFormat(time: originPostTime!)
            lblPostTime.text = postTimeDateFormat?.timeAgoSince(postTimeDateFormat!)
            
            // Posting 내용 설정
            txtvwContent.text = detailNewsPost?.content
            txtvwContent.postingInit()
            
            //            print(txtvwContents.text, "<---- ", newsPost?.createdAt)
            
            imgCnt = detailNewsPost?.images.count
            showImgFrame()
            
            // Repost 버튼
            isClickedRepost = false
            btnRepost.tintColor = .gray
            // Like 버튼
            if (detailNewsPost?.likers.contains(detailNewsPost!.userID) ?? false) {
                // 로그인 한 사용자가 좋아요를 누른 상태일 경우
                btnLike.isSelected = true
                numLike = detailNewsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .selected)
                btnLike.tintColor = .systemPink
                isClickedLike = true
            } else {
                // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
                print("여기를 통과하는지 확인")
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
            TopToUserImg.isActive = false
            TopToRepostImg.isActive = true
            repostPic.isHidden = false
            lblRepostInfo.isHidden = false
            lblRepostInfo.text = (detailNewsPost?.user.nickname)! + " 님이 공유했습니다"
            
            // User 정보 설정
            lblUserId.text = detailNewsPost?.retweet!.user.nickname
            lblUserId.sizeToFit()
            let originPostTime = detailNewsPost?.retweet?.createdAt
            let postTimeDateFormat = originPostTime!.getDateFormat(time: originPostTime!)
            lblPostTime.text = postTimeDateFormat!.timeAgoSince(postTimeDateFormat!)
            
            // Posting 내용 설정
            txtvwContent.text = detailNewsPost?.retweet!.content
            txtvwContent.postingInit()
            
            //            print(txtvwContents.text, "<---- ", newsPost?.retweet?.createdAt)
            
            imgCnt = detailNewsPost?.retweet!.images.count
            showImgFrame()
            
            // Repost 버튼
            isClickedRepost = false
            btnRepost.isSelected = false
            btnRepost.tintColor = .gray
            btnRepost.isEnabled = false
            // Like 버튼
            isClickedLike = false
            numLike = nil
            btnLike.setTitle(String(""), for: .normal)
            btnLike.isEnabled = false
            // Comment 버튼
            numComment = 0
            setButtonPlain(btn: btnComment, num: numComment!, color: .gray, state: .normal)
            // More 버튼
            btnMore.isEnabled = false
        }
        //        print("좋아요 숫자 ====> ",numLike)
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
        let imageCnt = detailNewsPost?.images.count
        switch imageCnt {
        case 1:
            // ver. only OneImage
            vwSquare.isHidden = false
            
            imgvwOne.isHidden = false
            vwThree.isHidden = true
            vwFour.isHidden = true
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            imgvwOne.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[0].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        case 2:
            // ver. TwoFrame
            vwTwo.isHidden = false
            
            vwTwoToRepost.isActive = true
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwTwo {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                if num == 1 {
                    let leftImg = (detailNewsPost?.images.count ?? 0) - 2
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
                        lblTwoMoreImg.isHidden = false
                        lblTwoMoreImg.text = String(leftImg) + " +"
                        lblTwoMoreImg.sizeToFit()
                        //                        imageTapped(image: imgvw.image!)
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
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwThree {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                if num == 2 {
                    let leftImg = (detailNewsPost?.images.count ?? 0) - 3
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
                        //                        lblThreeMoreImg.isHidden = false
                        lblThreeMoreImg.text = String(leftImg) + " +"
                        lblThreeMoreImg.sizeToFit()
                    } else {
                        lblThreeMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        case 4:
            // ver. FourFrame
            vwSquare.isHidden = false
            
            imgvwOne.isHidden = true
            vwThree.isHidden = true
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwFour {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (detailNewsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                if num == 3 {
                    let leftImg = (detailNewsPost?.images.count ?? 0) - 4
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
                        //                        lblTwoMoreImg.isHidden = false
                        lblFourMoreImg.text = String(leftImg) + " +"
                        lblFourMoreImg.sizeToFit()
                    } else {
                        lblFourMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        default:
            // 보여줄 사진이 없는 경우(글만 표시)
            lblTwoMoreImg.isHidden = true
            lblThreeMoreImg.isHidden = true
            lblFourMoreImg.isHidden = true
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = true
        } // case문 종료
    } // <---ShowImageFrame 설정 끝
    
    func showProfile() {
        let profileSB = UIStoryboard(name: "ProfileVC", bundle: nil)
        let showProfileVC = profileSB.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
        //        let indexPath = IndexPath(row: 1, section: 0)
        //        showDetailNewsFeedVC.replyTV.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
        
        detailNewsFeedVC?.navigationController?.pushViewController(showProfileVC, animated: true)
    }
    
    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
}

/*
 //이미지 클릭 시 전환 코드구현 구간
 func imageTapped(image:UIImage){
 let newImageView = UIImageView(image: image)
 newImageView.frame = UIScreen.main.bounds
 newImageView.backgroundColor = .black
 newImageView.contentMode = .scaleAspectFit
 newImageView.isUserInteractionEnabled = true
 let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
 newImageView.addGestureRecognizer(tap)
 self.window?.rootViewController?.view.addSubview(newImageView)
 self.window?.rootViewController?.navigationController?.isNavigationBarHidden = true
 self.window?.rootViewController?.tabBarController?.tabBar.isHidden = true
 }
 
 //이미지 전체화면 종료
 @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
 self.window?.rootViewController?.navigationController?.isNavigationBarHidden = false
 self.window?.rootViewController?.tabBarController?.tabBar.isHidden = false
 sender.view?.removeFromSuperview()
 }
 */
extension HeaderNewsFeedView {
    func reportPost( content: String) {
        let userid = UserDefaults.standard.string(forKey: "id") ?? ""
        ContentService.shared.reportPost(userid, content) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print(res)
                
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
}
