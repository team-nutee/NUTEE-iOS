//
//  ProfileTVHV.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class ProfileTVHV: UITableViewHeaderFooterView {

    let profileImage = UIImageView()
    let setProfile = UIButton()
    let myNickLabel = UIButton()
    let myArticle1Btn = UIButton()
    let myArticle2Btn = UIButton()
    let myFollower1Btn = UIButton()
    let myFollower2Btn = UIButton()
    let myFollowing1Btn = UIButton()
    let myFollowing2Btn = UIButton()


    override func awakeFromNib() {
        super.awakeFromNib()

//        setProfile.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
//        myNickLabel.addTarget(self, action: #selector(settingProfile), for: .touchUpInside)
//        myFollowing1Btn.addTarget(self, action: #selector(viewFollowing), for: .touchUpInside)
//        myFollowing2Btn.addTarget(self, action: #selector(viewFollowing), for: .touchUpInside)
//        myFollower1Btn.addTarget(self, action: #selector(viewFollower), for: .touchUpInside)
//        myFollower2Btn.addTarget(self, action: #selector(viewFollower), for: .touchUpInside)
//        myArticle1Btn.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)
//        myArticle2Btn.addTarget(self, action: #selector(viewArticle), for: .touchUpInside)

        
        
    }
    
    func setInit(){
        self.contentView.addSubview(profileImage)
        self.contentView.addSubview(myNickLabel)
        self.contentView.addSubview(setProfile)
        self.contentView.addSubview(myArticle1Btn)
        self.contentView.addSubview(myArticle2Btn)
        self.contentView.addSubview(myFollower1Btn)
        self.contentView.addSubview(myFollower2Btn)
        self.contentView.addSubview(myFollowing1Btn)
        self.contentView.addSubview(myFollowing2Btn)
        
        let etcname : String = "nickname"
        let name = NSMutableAttributedString(string: etcname)
        name.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, etcname.count))
        
        profileImage.backgroundColor = .lightGray
        profileImage.setRounded(radius: 50)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
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
        myNickLabel.widthAnchor.constraint(equalToConstant: contentView.frame.size.width - 120).isActive = true
        
        let myArticle1 = NSMutableAttributedString(string: "10")
        myArticle1Btn.setAttributedTitle(myArticle1, for: .normal)
        myArticle1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myArticle1Btn.translatesAutoresizingMaskIntoConstraints = false
        myArticle1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myArticle1Btn.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myArticle1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myArticle1Btn.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 120)/3).isActive = true
        
        let myArticle2 = NSMutableAttributedString(string: "게시글")
        myArticle2Btn.setAttributedTitle(myArticle2, for: .normal)
        myArticle2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myArticle2Btn.translatesAutoresizingMaskIntoConstraints = false
        myArticle2Btn.topAnchor.constraint(equalTo: myArticle1Btn.bottomAnchor).isActive = true
        myArticle2Btn.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myArticle2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myArticle2Btn.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 120)/3).isActive = true
        
        let myFollwer1 = NSMutableAttributedString(string: "23")
        myFollower1Btn.setAttributedTitle(myFollwer1, for: .normal)
        myFollower1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myFollower1Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollower1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollower1Btn.leftAnchor.constraint(equalTo: myArticle1Btn.rightAnchor).isActive = true
        myFollower1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollower1Btn.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 120)/3).isActive = true
        
        let myFollwer2 = NSMutableAttributedString(string: "팔로워")
        myFollower2Btn.setAttributedTitle(myFollwer2, for: .normal)
        myFollower2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollower2Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollower2Btn.topAnchor.constraint(equalTo: myFollower1Btn.bottomAnchor).isActive = true
        myFollower2Btn.leftAnchor.constraint(equalTo: myArticle1Btn.rightAnchor).isActive = true
        myFollower2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollower2Btn.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 120)/3).isActive = true
        
        let myFollowing1 = NSMutableAttributedString(string: "71")
        myFollowing1Btn.setAttributedTitle(myFollowing1, for: .normal)
        myFollowing1Btn.titleLabel?.font = .systemFont(ofSize: 15)
        myFollowing1Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollowing1Btn.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollowing1Btn.leftAnchor.constraint(equalTo: myFollower2Btn.rightAnchor).isActive = true
        myFollowing1Btn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollowing1Btn.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 120)/3).isActive = true
        
        let myFollowing2 = NSMutableAttributedString(string: "팔로잉")
        myFollowing2Btn.setAttributedTitle(myFollowing2, for: .normal)
        myFollowing2Btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollowing2Btn.translatesAutoresizingMaskIntoConstraints = false
        myFollowing2Btn.topAnchor.constraint(equalTo: myFollowing1Btn.bottomAnchor).isActive = true
        myFollowing2Btn.leftAnchor.constraint(equalTo: myFollower2Btn.rightAnchor).isActive = true
        myFollowing2Btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollowing2Btn.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 120)/3).isActive = true

    }

//    @objc func settingProfile() {
//        let sb = UIStoryboard(name: "Profile", bundle: nil)
//        let setProfileVC = sb.instantiateViewController(withIdentifier: "SetProfileVC") as! SetProfileVC
//        setProfileVC.modalPresentationStyle = .fullScreen
//        
//        present(setProfileVC, animated: true, completion: nil)
//    }
//    
//    @objc func viewFollower() {
//        let sb = UIStoryboard(name: "Profile", bundle: nil)
//        let followerVC = sb.instantiateViewController(withIdentifier: "FollowerVC") as! FollowerVC
//        
//        navigationController?.pushViewController(followerVC, animated: true)
//    }
//    
//    @objc func viewFollowing() {
//        let sb = UIStoryboard(name: "Profile", bundle: nil)
//        let followingVC = sb.instantiateViewController(withIdentifier: "FollowingVC") as! FollowingVC
//        self.navigationController?.pushViewController(followingVC, animated: true)
//        
//    }
//    
//    @objc func viewArticle() {
//        let indexPath = NSIndexPath(row: 1, section: 0)
//        myArticleTV.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
//    }
//    
//    @IBAction func toSetting(){
//        let sb = UIStoryboard(name: "Profile", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
//        vc.modalPresentationStyle = .fullScreen
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

    
}
