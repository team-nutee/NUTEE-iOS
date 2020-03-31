//
//  ProfileVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

import Then
import SwiftKeychainWrapper
import SnapKit

class ProfileVC: UIViewController {
    // MARK: - UI components
    
    @IBOutlet weak var myArticleTV: UITableView!
    
    let headerView = UIView()
    let profileImage = UIImageView()
    let setProfile = UIButton()
    let myNickLabel = UIButton()
    let myArticle1Btn = UIButton()
    let myArticle2Btn = UIButton()
    let myFollower1Btn = UIButton()
    let myFollower2Btn = UIButton()
    let myFollowing1Btn = UIButton()
    let myFollowing2Btn = UIButton()
    
    let followBtn = UIButton()
    
    let cellTextLabel = UILabel()
    
//    lazy var leftBarButton : UIBarButtonItem = {
//        let button = UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(logoutButton))
//        return button
//    }()
    
    lazy var rightBarButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(toSetting))
        return button
    }()

    // MARK: - Variables and Properties
    
    var userInfo: SignIn?
    var userPosts: UserPostContent?
    // 기본적으로 로그인한 사용자의 아이디 값으로 설정
    var userId = KeychainWrapper.standard.integer(forKey: "id")
    
    var isInit : Bool = false
    var isFollow: Bool = false
    var isFollowTxt : String = "팔로우하기"
    var follwerCnt : Int?
    var myFollower1 : NSMutableAttributedString?
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myArticleTV.delegate = self
        myArticleTV.dataSource = self
        self.myArticleTV.register(ArticleTVC.self, forCellReuseIdentifier: "ArticleTVC")
                
        myArticleTV.register(UINib(nibName: "ProflieTableViewCell", bundle: nil), forCellReuseIdentifier: "ProflieTableViewCell")
        myArticleTV.separatorInset.left = 0
        
        setBtn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         // 네비바 border 삭제
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 보여주려는 프로필 정보가 로그인 사용자인지 다른 사람인지 확인
        if userId == KeychainWrapper.standard.integer(forKey: "id") {
            getLoginUserInfoService(completionHandler: {(returnedData)-> Void in
                self.getUserPostService(userId: self.userInfo!.id)
            })
        } else {
            getUserInfoService(userId: userId ?? 0, completionHandler: {(returnedData)-> Void in
                self.getUserPostService(userId: self.userId ?? 0)
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        
    }
    
    func setDefault() {
        
    }
    
    func setBtn(){
        //        self.navigationItem.leftBarButtonItem = self.leftBarButton
        
        // userId 값이 로그인 한 사용자 일때만 활성화
        if userId == KeychainWrapper.standard.integer(forKey: "id") {
            self.navigationItem.rightBarButtonItem = self.rightBarButton
            
            myNickLabel.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
        }
        setProfile.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
        myFollowing1Btn.addTarget(self, action: #selector(viewFollowing), for: .touchUpInside)
        myFollowing2Btn.addTarget(self, action: #selector(viewFollowing), for: .touchUpInside)
        myFollower1Btn.addTarget(self, action: #selector(viewFollower), for: .touchUpInside)
        myFollower2Btn.addTarget(self, action: #selector(viewFollower), for: .touchUpInside)
        myArticle1Btn.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)
        myArticle2Btn.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)
        followBtn.addTarget(self, action: #selector(followAction), for: .touchUpInside)

    }
    
    @objc func settingProfile() {
        let setProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "SetProfileVC") as! SetProfileVC
        setProfileVC.modalPresentationStyle = .fullScreen
        setProfileVC.name = userInfo!.nickname
        setProfileVC.profileImgSrc = userInfo?.image.src
        
        self.present(setProfileVC, animated: true, completion: nil)
    }
    
    @objc func viewFollower() {
        let followerVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowerVC") as! FollowerVC
        
        // ProfileVC에서 표시하고 있는 프로필 사용자의 내부 id값을 FollowerVC로 전달
        followerVC.userId = userInfo?.id ?? 0
        
        self.navigationController?.pushViewController(followerVC, animated: true)
    }
    
    @objc func viewFollowing() {
        let followingVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowingVC") as! FollowingVC
        
        // ProfileVC에서 표시하고 있는 프로필 사용자의 내부 id값을 FollowingVC로 전달
        followingVC.userId = userInfo?.id ?? 0
        
        self.navigationController?.pushViewController(followingVC, animated: true)
    }
    
    @objc func viewArticle() {
        if (userPosts?.count) == 0 { } else {
            let indexPath = IndexPath(row: 1, section: 0)
            myArticleTV.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
        }
    }
    
    @objc func followAction() {
        if isFollow == false {
            follow(userId: userId ?? 0)
        } else {
            unfollow(userId: userId ?? 0)
        }
    }
    
    @IBAction func toSetting(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableView

extension ProfileVC : UITableViewDelegate { }

extension ProfileVC : UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var userPostsNum = userPosts?.count ?? 0
        userPostsNum += 1
        
        if userPostsNum == 1 {
            tableView.setEmptyView(title: "게시글이 없습니다", message: "새로운 게시물을 올려보세요‼️")
        } else {
            tableView.restore()
        }
        
        return userPostsNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProflieTableViewCell",
                                                 for: indexPath) as! ProflieTableViewCell
        
        myArticleTV.separatorStyle = .singleLine
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = nil
            textViewDidChange(cell.articleTextView)
            let userPost = userPosts?[indexPath.row-1]
            
            // ProfileTableViewCell로 해당 Cell의 게시글 정보 전달
            cell.loginUserPost = userPost
            
            cell.initLoginUserPost()
            
//            cell.profileNameLabel.text = userPost?.user.nickname
//            cell.articleTextView.text = userPost?.content
//
//            if userInfo?.image.src == "" {
//            cell.profileIMG.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
//            } else {
//            cell.profileIMG.imageFromUrl((APIConstants.BaseURL) + "/" + (userInfo?.image.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
//            }
//            let originUserPostTime = userPost?.createdAt
//            let userPostTimeDateFormat = originUserPostTime!.getDateFormat(time: originUserPostTime!)
//            cell.timeLabel.text = userPostTimeDateFormat!.timeAgoSince(userPostTimeDateFormat!)
//
//            cell.articleTextView.postingInit()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0.5
        } else {
            return UITableView.automaticDimension
        }
    }
        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "ArticleTVC", for: indexPath) as! ArticleTVC
        
        let sb = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC
        
        vc.postId = userPosts?[indexPath.row - 1].id
        vc.getPostService(postId: vc.postId!, completionHandler: {(returnedData) -> Void in
            vc.replyTV.reloadData()
        })
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK : headerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.headerView.backgroundColor = .white
        self.headerView.addSubview(profileImage)
        self.headerView.addSubview(myNickLabel)
        // userId 값이 로그인 한 사용자 일때만 활성화
        if userId == KeychainWrapper.standard.integer(forKey: "id") {
            self.headerView.addSubview(setProfile)
        }
        self.headerView.addSubview(myArticle1Btn)
        self.headerView.addSubview(myArticle2Btn)
        self.headerView.addSubview(myFollower1Btn)
        self.headerView.addSubview(myFollower2Btn)
        self.headerView.addSubview(myFollowing1Btn)
        self.headerView.addSubview(myFollowing2Btn)
        self.headerView.addSubview(followBtn)
        
        let etcname : String = userInfo?.nickname ?? ""
        
        let name = NSMutableAttributedString(string: etcname)
        // userId 값이 로그인 한 사용자 일때만 활성화
        if userId == KeychainWrapper.standard.integer(forKey: "id") {
            name.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, etcname.count))
        }
        
        // 팔로우 하기 버튼 활성화
        if KeychainWrapper.standard.integer(forKey: "id") != userId {
            followBtn.isHidden = false
        } else {
            followBtn.isHidden = true
        }
        

        if userInfo?.image.src == "" {
        profileImage.imageFromUrl("http://15.164.50.161:9425/settings/nutee_profile.png", defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        }else{
        profileImage.imageFromUrl((APIConstants.BaseURL) + "/" + (userInfo?.image.src ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")
        }

        profileImage.contentMode = .scaleAspectFill
        profileImage.setRounded(radius: 50)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        profileImage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 15).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // userId 값이 로그인 한 사용자 일때만 활성화
        if userId == KeychainWrapper.standard.integer(forKey: "id") {
            setProfile.setImage(.add, for: .normal)
            setProfile.tintColor = .black
            setProfile.translatesAutoresizingMaskIntoConstraints = false
            setProfile.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -20).isActive = true
            setProfile.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: -20).isActive = true
            setProfile.heightAnchor.constraint(equalToConstant: 20).isActive = true
            setProfile.widthAnchor.constraint(equalToConstant: 20).isActive = true
            setProfile.setRounded(radius: 10)
        }
        
        myNickLabel.setAttributedTitle(name, for: .normal)
        myNickLabel.setTitleColor(.black, for: .normal)
        myNickLabel.setTitleColor(.blue, for: .highlighted)
        myNickLabel.titleLabel?.font = .boldSystemFont(ofSize: 20)
        myNickLabel.translatesAutoresizingMaskIntoConstraints = false
        myNickLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10).isActive = true
        myNickLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myNickLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myNickLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 120).isActive = true
        
        let myArticle1 = NSMutableAttributedString(string: String(userInfo?.posts.count ?? 0))
        myArticle1Btn.setAttributedTitle(myArticle1, for: .normal)
        myArticle1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myArticle1Btn.translatesAutoresizingMaskIntoConstraints = false
        myArticle1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myArticle1Btn.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myArticle1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myArticle1Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let myArticle2 = NSMutableAttributedString(string: "게시글")
        myArticle2Btn.setAttributedTitle(myArticle2, for: .normal)
        myArticle2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myArticle2Btn.translatesAutoresizingMaskIntoConstraints = false
        myArticle2Btn.topAnchor.constraint(equalTo: myArticle1Btn.bottomAnchor).isActive = true
        myArticle2Btn.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myArticle2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myArticle2Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        if !isInit {
            follwerCnt = userInfo?.followers.count
        }
        myFollower1 = NSMutableAttributedString(string: String(follwerCnt ?? 0))
        myFollower1Btn.setAttributedTitle(myFollower1, for: .normal)
        myFollower1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myFollower1Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollower1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollower1Btn.leftAnchor.constraint(equalTo: myArticle1Btn.rightAnchor).isActive = true
        myFollower1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollower1Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let myFollower2 = NSMutableAttributedString(string: "팔로워")
        myFollower2Btn.setAttributedTitle(myFollower2, for: .normal)
        myFollower2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollower2Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollower2Btn.topAnchor.constraint(equalTo: myFollower1Btn.bottomAnchor).isActive = true
        myFollower2Btn.leftAnchor.constraint(equalTo: myArticle1Btn.rightAnchor).isActive = true
        myFollower2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollower2Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let myFollowing1 = NSMutableAttributedString(string: String(userInfo?.followings.count ?? 0))
        myFollowing1Btn.setAttributedTitle(myFollowing1, for: .normal)
        myFollowing1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myFollowing1Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollowing1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollowing1Btn.leftAnchor.constraint(equalTo: myFollower2Btn.rightAnchor).isActive = true
        myFollowing1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollowing1Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let myFollowing2 = NSMutableAttributedString(string: "팔로잉")
        myFollowing2Btn.setAttributedTitle(myFollowing2, for: .normal)
        myFollowing2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollowing2Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollowing2Btn.topAnchor.constraint(equalTo: myFollowing1Btn.bottomAnchor).isActive = true
        myFollowing2Btn.leftAnchor.constraint(equalTo: myFollower2Btn.rightAnchor).isActive = true
        myFollowing2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollowing2Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let followBtnText = NSMutableAttributedString(string: isFollowTxt)
        followBtn.setAttributedTitle(followBtnText, for: .normal)
        followBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        followBtn.translatesAutoresizingMaskIntoConstraints = false
        followBtn.borderColor = .nuteeGreen
        followBtn.borderWidth = 0.3
        followBtn.makeRounded(cornerRadius: 11)
        followBtn.topAnchor.constraint(equalTo: myFollowing2Btn.bottomAnchor).isActive = true
        followBtn.leftAnchor.constraint(equalTo: profileImage.rightAnchor).isActive = true
        followBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        followBtn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)).isActive = true

        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    // tableView의 마지막 cell 밑의 여백 발생 문제(footerView의 기본 높이 값) 제거 코드
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

extension ProfileVC: UITextViewDelegate {
    
    // TextView의 동적인 크기 변화를 위한 function
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
}

//MARK: - UserInfo와 UserPost 서버 연결을 위한 Service 실행 구간

extension ProfileVC {
    func getLoginUserInfoService(completionHandler: @escaping (_ returnedData: SignIn) -> Void ) {
        UserService.shared.getLoginUserInfo() { responsedata in
            
            switch responsedata {
            case .success(let res):
                
                let response = res as! SignIn
                self.userInfo = response
                
                completionHandler(self.userInfo!)
                
                self.myArticleTV.reloadData()
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
    
    func getUserInfoService(userId: Int, completionHandler: @escaping (_ returnedData: SignIn) -> Void ) {
        UserService.shared.getUserInfo(userId: userId) { responsedata in
            
            switch responsedata {
            case .success(let res):
                
                let response = res as! SignIn
                self.userInfo = response
                
                completionHandler(self.userInfo!)
                
                self.myArticleTV.reloadData()
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
    
    func getUserPostService(userId: Int) {
        ContentService.shared.getUserPosts(userId) { responsedata in

            switch responsedata {
            case .success(let res):
                let response = res as! UserPostContent
                self.userPosts = response
                
                self.myArticleTV.reloadData()
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

    func follow(userId: Int) {
        FollowService.shared.follow(userId) { responsedata in

            switch responsedata {
            case .success(_):
                self.isInit = true
                self.isFollowTxt = "언팔로우"
                self.isFollow = !self.isFollow
                self.follwerCnt = (self.follwerCnt ?? 0) + 1
                
                self.myArticleTV.reloadData()

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

    func unfollow(userId: Int) {
        FollowService.shared.unFollow(userId) { responsedata in

            switch responsedata {
            case .success(_):
                self.isInit = true
                self.isFollowTxt = "팔로우하기"
                self.isFollow = !self.isFollow
                self.follwerCnt = (self.follwerCnt ?? 0) - 1
                
                self.myArticleTV.reloadData()

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
