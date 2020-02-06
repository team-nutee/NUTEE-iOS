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
    
    @IBOutlet var imgViewUserImage: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet weak var profileLineView: UIView!
    @IBOutlet weak var myArticleTV: UITableView!
    
    // MARK: - Variables and Properties
    
    let headerView = UIView()
    let profileImage = UIImageView()
    let setProfile = UIButton()
    let myNickLabel = UIButton()
    let myArticle1Button = UIButton()
    let myArticle2Button = UIButton()
    let myFollwer1Button = UIButton()
    let myFollwer2Button = UIButton()
    let myFollowing1Button = UIButton()
    let myFollowing2Button = UIButton()
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myArticleTV.delegate = self
        myArticleTV.dataSource = self
        myArticleTV.register(MyArticleTVC.self, forCellReuseIdentifier: "MyArticleTVC")
    }
    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        imgViewUserImage.image = UIImage(named: "nutee_zigi")
        lblUserId.text = "zigi"
        
        //        myArticleTV.layer.addBorder([.top], color: .veryLightPink, width: 1)
        imgViewUserImage.setRounded(radius: nil)
        
//        let headerView = UIView(frame: CGRect.zero)
        
//        self.myArticleTV.sectionHeaderHeight = 200
//        self.view.addSubview(headerView)
        
    }
    
    func setDefault() {
        
    }
    
}

extension ProfileVC : UITableViewDelegate { }

extension ProfileVC : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyArticleTVC", for: indexPath) as! MyArticleTVC

//        cell.articelLabel.text = "테스트입니다"
//        cell.backgroundColor = .v eryLightPink
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        headerView.backgroundColor = .white
                
        self.headerView.addSubview(profileImage)
        self.headerView.addSubview(myNickLabel)
        self.headerView.addSubview(setProfile)
        self.headerView.addSubview(myArticle1Button)
        self.headerView.addSubview(myArticle2Button)
        self.headerView.addSubview(myFollwer1Button)
        self.headerView.addSubview(myFollwer2Button)
        self.headerView.addSubview(myFollowing1Button)
        self.headerView.addSubview(myFollowing2Button)
        
        let etcname : String = "nickname"
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
        
        myArticle1Button.setTitle("10", for: .normal)
        myArticle1Button.setTitleColor(.black, for: .normal)
        myArticle1Button.setTitleColor(.blue, for: .highlighted)
        myArticle1Button.titleLabel?.font = .systemFont(ofSize: 15)
        myArticle1Button.translatesAutoresizingMaskIntoConstraints = false
        myArticle1Button.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myArticle1Button.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myArticle1Button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myArticle1Button.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true

        myArticle2Button.setTitle("게시글", for: .normal)
        myArticle2Button.setTitleColor(.black, for: .normal)
        myArticle2Button.setTitleColor(.blue, for: .highlighted)
        myArticle2Button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myArticle2Button.translatesAutoresizingMaskIntoConstraints = false
        myArticle2Button.topAnchor.constraint(equalTo: myArticle1Button.bottomAnchor).isActive = true
        myArticle2Button.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        myArticle2Button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myArticle2Button.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true

        myFollwer1Button.setTitle("30", for: .normal)
        myFollwer1Button.setTitleColor(.black, for: .normal)
        myFollwer1Button.setTitleColor(.blue, for: .highlighted)
        myFollwer1Button.titleLabel?.font = .systemFont(ofSize: 15)
        myFollwer1Button.translatesAutoresizingMaskIntoConstraints = false
        myFollwer1Button.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollwer1Button.leftAnchor.constraint(equalTo: myArticle1Button.rightAnchor).isActive = true
        myFollwer1Button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollwer1Button.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true

        myFollwer2Button.setTitle("팔로워", for: .normal)
        myFollwer2Button.setTitleColor(.black, for: .normal)
        myFollwer2Button.setTitleColor(.blue, for: .highlighted)
        myFollwer2Button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollwer2Button.translatesAutoresizingMaskIntoConstraints = false
        myFollwer2Button.topAnchor.constraint(equalTo: myFollwer1Button.bottomAnchor).isActive = true
        myFollwer2Button.leftAnchor.constraint(equalTo: myArticle1Button.rightAnchor).isActive = true
        myFollwer2Button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollwer2Button.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true

        myFollowing1Button.setTitle("40", for: .normal)
        myFollowing1Button.setTitleColor(.black, for: .normal)
        myFollowing1Button.setTitleColor(.blue, for: .highlighted)
        myFollowing1Button.titleLabel?.font = .systemFont(ofSize: 15)
        myFollowing1Button.translatesAutoresizingMaskIntoConstraints = false
        myFollowing1Button.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 50).isActive = true
        myFollowing1Button.leftAnchor.constraint(equalTo: myFollwer2Button.rightAnchor).isActive = true
        myFollowing1Button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        myFollowing1Button.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true

        myFollowing2Button.setTitle("팔로잉", for: .normal)
        myFollowing2Button.setTitleColor(.black, for: .normal)
        myFollowing2Button.setTitleColor(.blue, for: .highlighted)
        myFollowing2Button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        myFollowing2Button.translatesAutoresizingMaskIntoConstraints = false
        myFollowing2Button.topAnchor.constraint(equalTo: myFollowing1Button.bottomAnchor).isActive = true
        myFollowing2Button.leftAnchor.constraint(equalTo: myFollwer2Button.rightAnchor).isActive = true
        myFollowing2Button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myFollowing2Button.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 120)/3).isActive = true

        


        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
}


