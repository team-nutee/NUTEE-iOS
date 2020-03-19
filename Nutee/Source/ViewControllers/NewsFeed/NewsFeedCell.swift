//
//  NewsFeedVO.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    //MARK: - UI components
    
    @IBOutlet var contentsCell: UIView!
    // Repost Info Section
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
    @IBOutlet var ContentToVwTwo: NSLayoutConstraint!
    @IBOutlet var vwTwoToRepost: NSLayoutConstraint!
    
    //앨범 프레임 three, four 버전을 통합관리 할 view 객체 생성
    @IBOutlet var vwSquare: UIView!
    @IBOutlet var ContentToVwSquare: NSLayoutConstraint!
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
    
    @IBAction func btnComment(sender: Any) {
        showDetailNewsFeed()
    }
    
    //수정, 삭제 알림창 기능
    @IBAction func btnMore(sender: AnyObject) {
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
            self.newsFeedVC?.present(deleteAlert, animated: true, completion: nil)
        }
        let userReportAction = UIAlertAction(title: "신고하기🚨", style: .destructive) {
            (action: UIAlertAction) in
            // Code to 신고 기능
            let reportAlert = UIAlertController(title: "이 게시글을 신고하시겠습니까?", message: "\(String(self.txtvwContent.text))", preferredStyle: UIAlertController.Style.alert)
            let cancelAction
                = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let reportAction = UIAlertAction(title: "신고", style: .destructive) {
                (action: UIAlertAction) in
                // <---- 신고 기능 구현
                
                //신고 여부 알림
                let successfulAlert = UIAlertController(title: nil, message: "신고가 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                successfulAlert.addAction(okAction)
                
                self.newsFeedVC?.present(successfulAlert, animated: true, completion: nil)
            }
            reportAlert.addAction(cancelAction)
            reportAlert.addAction(reportAction)
            
            self.newsFeedVC?.present(reportAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        let userid = Int(UserDefaults.standard.string(forKey: "id") ?? "")
        
        if (userid == newsPost?.userID) {
            moreAlert.addAction(editAction)
            moreAlert.addAction(deleteAction)
            moreAlert.addAction(cancelAction)
        } else {
            moreAlert.addAction(userReportAction)
            moreAlert.addAction(cancelAction)
        }
        
        newsFeedVC?.present(moreAlert, animated: true, completion: nil)
    }
    
    //포스팅 내용 초기설정
    func initPosting() {
        imgvwUserImg.image = #imageLiteral(resourceName: "defaultProfile")
        imgvwUserImg.setRounded(radius: nil)
        
        if newsPost?.retweetID == nil {
            // <-----공유한 글이 아닐 경우-----> //
            TopToUserImg.isActive = true
            TopToRepostImg.isActive = false
            lblRepostInfo.isHidden = true
            
            // User 정보 설정
            lblUserId.text = newsPost?.user.nickname
            lblUserId.sizeToFit()
            let originPostTime = newsPost?.createdAt
            let postTimeDateFormat = originPostTime!.getDateFormat(time: originPostTime!)
            lblPostTime.text = postTimeDateFormat!.timeAgoSince(postTimeDateFormat!)

            // Posting 내용 설정
            txtvwContent.text = newsPost?.content
            txtvwContent.postingInit()
            
//            print(txtvwContents.text, "<---- ", newsPost?.createdAt)
            
            imgCnt = newsPost?.images.count
            showImgFrame()
            
            // Repost 버튼
            isClickedRepost = false
            btnRepost.tintColor = .gray
            // Like 버튼
            if (newsPost?.likers.contains(newsPost!.userID) ?? false) {
                // 로그인 한 사용자가 좋아요를 누른 상태일 경우
                btnLike.isSelected = true
                numLike = newsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .selected)
                btnLike.tintColor = .systemPink
                isClickedLike = true
            } else {
                // 로그인 한 사용자가 좋아요를 누르지 않은 상태일 경우
                btnLike.isSelected = false
                numLike = newsPost?.likers.count ?? 0
                btnLike.setTitle(" " + String(numLike!), for: .normal)
                btnLike.tintColor = .gray
                isClickedLike = false
            }
            // Comment 버튼
            numComment = newsPost?.comments.count ?? 0
            setButtonPlain(btn: btnComment, num: numComment!, color: .gray, state: .normal)
        } else {
            // <-----공유한 글 일 경우-----> //
            TopToUserImg.isActive = false
            TopToRepostImg.isActive = true
            lblRepostInfo.isHidden = false
            lblRepostInfo.text = (newsPost?.user.nickname)! + " 님이 공유했습니다"
            
            // User 정보 설정
            lblUserId.text = newsPost?.retweet!.user.nickname
            lblUserId.sizeToFit()
            let originPostTime = newsPost?.retweet?.createdAt
            let postTimeDateFormat = originPostTime!.getDateFormat(time: originPostTime!)
            lblPostTime.text = postTimeDateFormat!.timeAgoSince(postTimeDateFormat!)
            
            // Posting 내용 설정
            txtvwContent.text = newsPost?.retweet!.content
            txtvwContent.postingInit()
            
//            print(txtvwContents.text, "<---- ", newsPost?.retweet?.createdAt)
            
            imgCnt = newsPost?.retweet!.images.count
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
        
//        let postUserProfile = UIButton()
//        lblUserId.addSubview(postUserProfile)
//        postUserProfile.addTarget(self, action: #selector(goPostUserPorfile), for: .touchUpInside)
    }
    
//    @objc func goPostUserPorfile() {
//        print("과연 작동이 될까요~~")
//    }
    
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
        let imageCnt = newsPost?.images.count
        switch imageCnt {
        case 1:
            // ver. only OneImage
            vwSquare.isHidden = false
            
            imgvwOne.isHidden = false
            vwThree.isHidden = true
            vwFour.isHidden = true
            
            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            ContentToVwSquare.isActive = true
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            imgvwOne.imageFromUrl((APIConstants.BaseURL) + "/" + (newsPost?.images[0].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")

        case 2:
            // ver. TwoFrame
            vwTwo.isHidden = false
            
            ContentToVwTwo.isActive = true
            vwTwoToRepost.isActive = true
            ContentToVwSquare.isActive = false
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwTwo {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (newsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                if num == 1 {
                    let leftImg = (newsPost?.images.count ?? 0) - 2
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
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
            
            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            ContentToVwSquare.isActive = true
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwThree {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (newsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                if num == 2 {
                    let leftImg = (newsPost?.images.count ?? 0) - 3
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
            
            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            ContentToVwSquare.isActive = true
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwFour {
                imgvw.imageFromUrl((APIConstants.BaseURL) + "/" + (newsPost?.images[num].src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
                if num == 3 {
                    let leftImg = (newsPost?.images.count ?? 0) - 4
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
            
            ContentToVwTwo.isActive = false
            vwTwoToRepost.isActive = false
            ContentToVwSquare.isActive = false
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = true
        } // case문 종료
    } // ShowImageFrame 설정 끝
    
    func setClickActions() {
        imgvwUserImg.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        imgvwUserImg.isUserInteractionEnabled = true
        imgvwUserImg.addGestureRecognizer(tapGestureRecognizer1)
        
        lblUserId.tag = 2
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(lblTapped(tapGestureRecognizer:)))
        tapGestureRecognizer2.numberOfTapsRequired = 2
        lblUserId.isUserInteractionEnabled = true
        lblUserId.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
        print("your taped image view tag is : \(imgView.tag)")
        
        //Give your image View tag
        if (imgView.tag == 1) {
            let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
            newsFeedVC?.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @objc func lblTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let lbl = tapGestureRecognizer.view as! UIImageView
        print("your taped label view tag is : \(lbl.tag)")
        
        //Give your label tag
        if (lbl.tag == 2) {
            let vc = UIStoryboard.init(name: "Profile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
            newsFeedVC?.navigationController?.pushViewController(vc!, animated: true)
        }
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
            let profileSB = UIStoryboard(name: "ProfileVC", bundle: nil)
            let showProfileVC = profileSB.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            
    //        let indexPath = IndexPath(row: 1, section: 0)
    //        showDetailNewsFeedVC.replyTV.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
            
            newsFeedVC?.navigationController?.pushViewController(showProfileVC, animated: true)
    }

    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
    
}

extension NewsFeedCell {
    func reportPost( content: String, postId : String, completionHandler: @escaping (_ returnedData: NewsPostsContent) -> Void ) {
        let userid = UserDefaults.standard.string(forKey: "id") ?? ""
        ContentService.shared.reportPost(userid, content, postId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                LoadingHUD.hide()
                print(res)
                
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
