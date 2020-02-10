//
//  ProfileVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

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
    
    var test: [String] = ["123","123","","","","","","","","","",""]
//    var test: [String] = []

    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myArticleTV.delegate = self
        myArticleTV.dataSource = self
        self.myArticleTV.register(ArticleTVC.self, forCellReuseIdentifier: "ArticleTVC")
        
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         // 네비바 border 삭제
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }

    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        
    }
    
    func setDefault() {
        
    }
    
    func setBtn(){
        //        self.navigationItem.leftBarButtonItem = self.leftBarButton
        self.navigationItem.rightBarButtonItem = self.rightBarButton
        
        setProfile.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
        myNickLabel.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
        myFollowing1Btn.addTarget(self, action: #selector(viewFollowing), for: .touchUpInside)
        myFollowing2Btn.addTarget(self, action: #selector(viewFollowing), for: .touchUpInside)
        myFollower1Btn.addTarget(self, action: #selector(viewFollower), for: .touchUpInside)
        myFollower2Btn.addTarget(self, action: #selector(viewFollower), for: .touchUpInside)
        myArticle1Btn.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)
        myArticle2Btn.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)

    }
    
    @objc func settingProfile() {
        let setProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "SetProfileVC") as! SetProfileVC
        setProfileVC.modalPresentationStyle = .fullScreen
        setProfileVC.name = UserDefaults.standard.value(forKey: "cookie") as! String
        
        self.present(setProfileVC, animated: true, completion: nil)
    }
    
    @objc func viewFollower() {
        let followerVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowerVC") as! FollowerVC
        
        self.navigationController?.pushViewController(followerVC, animated: true)
    }
    
    @objc func viewFollowing() {
        let followingVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowingVC") as! FollowingVC
        
        self.navigationController?.pushViewController(followingVC, animated: true)
    }
    
    @objc func viewArticle() {
        let indexPath = NSIndexPath(row: 1, section: 0)
        myArticleTV.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
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
        if test.count == 0{
            tableView.setEmptyView(title: "게시글이 없습니다", message: "새로운 게시물을 올려보세요‼️")
        } else {
            tableView.restore()
        }
        return test.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTVC", for: indexPath) as! ArticleTVC
        
        if indexPath.row == 0 {
//            cell.backgroundColor = .lightGray
//            cell.alpha = 0.3
        } else {
            cell.addSubview(cellTextLabel)
            cellTextLabel.text = String(indexPath.row) + "번째"
            cellTextLabel.font = .boldSystemFont(ofSize: 20)
            cellTextLabel.textAlignment = .center
            cellTextLabel.translatesAutoresizingMaskIntoConstraints = false
            cellTextLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
            cellTextLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 0.3
        } else {
            return 70
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTVC", for: indexPath) as! ArticleTVC
        
        let sb = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailNewsFeed")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK : headerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        self.headerView.addSubview(profileImage)
        self.headerView.addSubview(myNickLabel)
        self.headerView.addSubview(setProfile)
        self.headerView.addSubview(myArticle1Btn)
        self.headerView.addSubview(myArticle2Btn)
        self.headerView.addSubview(myFollower1Btn)
        self.headerView.addSubview(myFollower2Btn)
        self.headerView.addSubview(myFollowing1Btn)
        self.headerView.addSubview(myFollowing2Btn)
        
        let etcname : String = UserDefaults.standard.value(forKey: "cookie") as! String
        
        let name = NSMutableAttributedString(string: etcname)
        name.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, etcname.count))
        
        profileImage.backgroundColor = .lightGray
        profileImage.setRounded(radius: 50)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        profileImage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 15).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        setProfile.setImage(.add, for: .normal)
        setProfile.tintColor = .black
        setProfile.translatesAutoresizingMaskIntoConstraints = false
        setProfile.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -20).isActive = true
        setProfile.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: -20).isActive = true
        setProfile.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setProfile.widthAnchor.constraint(equalToConstant: 20).isActive = true
        setProfile.setRounded(radius: 10)
        
        myNickLabel.setAttributedTitle(name, for: .normal)
        myNickLabel.setTitleColor(.black, for: .normal)
        myNickLabel.setTitleColor(.blue, for: .highlighted)
        myNickLabel.titleLabel?.font = .boldSystemFont(ofSize: 20)
        myNickLabel.translatesAutoresizingMaskIntoConstraints = false
        myNickLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10).isActive = true
        myNickLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myNickLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myNickLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 120).isActive = true
        
        let myArticle1 = NSMutableAttributedString(string: "10")
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
        
        let myFollwer1 = NSMutableAttributedString(string: "23")
        myFollower1Btn.setAttributedTitle(myFollwer1, for: .normal)
        myFollower1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myFollower1Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollower1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollower1Btn.leftAnchor.constraint(equalTo: myArticle1Btn.rightAnchor).isActive = true
        myFollower1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollower1Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let myFollwer2 = NSMutableAttributedString(string: "팔로워")
        myFollower2Btn.setAttributedTitle(myFollwer2, for: .normal)
        myFollower2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollower2Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollower2Btn.topAnchor.constraint(equalTo: myFollower1Btn.bottomAnchor).isActive = true
        myFollower2Btn.leftAnchor.constraint(equalTo: myArticle1Btn.rightAnchor).isActive = true
        myFollower2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollower2Btn.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true
        
        let myFollowing1 = NSMutableAttributedString(string: "71")
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
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
}


